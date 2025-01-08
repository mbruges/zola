<script>
    function addTooltips(annotationsArray) {
        const textArray = Array.from(
            document.getElementsByClassName(
                "hypothesis-highlight user-annotations",
            ),
        );
        console.log(textArray);
        textArray.forEach((highlight, index) => {
            const annotation = annotationsArray[index]; // Assuming order matches
            console.log(annotation);
            if (annotation) {
                console.log("annotation added");
                let tooltip = document.createElement("div");
                tooltip.className = "tooltip";
                tooltip.textContent = annotation.annotationText;
                highlight.appendChild(tooltip);
                highlight.addEventListener("mouseenter", () => {
                    console.log("mousedover");
                    tooltip.style.display = "block";
                    const rect = highlight.getBoundingClientRect();
                    tooltip.style.left = `${rect.left + window.scrollX}px`;
                    tooltip.style.top = `${rect.top + window.scrollY - tooltip.offsetHeight - 5}px`;
                });

                highlight.addEventListener("mouseleave", () => {
                    tooltip.style.display = "none";
                });
            }
        });
    }

    async function fetchAnnotations() {
        const pageUrl = encodeURIComponent(window.location.href);
        const response = await fetch(
            `https://hypothes.is/api/search?uri=${pageUrl}`,
            {
                headers: {
                    Accept: "application/vnd.hypothesis.v1+json",
                },
            },
        );

        if (response.ok) {
            const data = await response.json();
            const annotationsArray = data.rows
                .map((annotation) => {
                    const textQuote =
                        annotation.target
                            .find(
                                (t) =>
                                    t.selector &&
                                    t.selector.some(
                                        (s) => s.type === "TextQuoteSelector",
                                    ),
                            )
                            ?.selector.find(
                                (s) => s.type === "TextQuoteSelector",
                            )?.exact || "";

                    const startPosition =
                        annotation.target
                            .find(
                                (t) =>
                                    t.selector &&
                                    t.selector.some(
                                        (s) =>
                                            s.type === "TextPositionSelector",
                                    ),
                            )
                            ?.selector.find(
                                (s) => s.type === "TextPositionSelector",
                            )?.start || null;

                    return {
                        targetText: textQuote,
                        annotationText: annotation.text,
                        author: annotation.user.split(":")[1], // Extracts the username
                        startPosition: startPosition,
                    };
                })
                .filter((item) => item.startPosition !== null); // Filter out items without start position

            // Sort by start position
            annotationsArray.sort((a, b) => a.startPosition - b.startPosition);

            console.log("annotations collected");
            return annotationsArray;
        } else {
            console.error("Error fetching annotations:", response.statusText);
        }
    }

    const annotationsArrayPromise = fetchAnnotations();
    window.annotationsArrayPromise = annotationsArrayPromise; // Make it globally accessible
</script>

<script async src="https://hypothes.is/embed.js"></script>

<script>
    window.hypothesisConfig = function () {
        return {
            openSidebar: false,
            theme: "minimal",
            showHighlights: "always",
        };
    };
    document.addEventListener("DOMContentLoaded", () => {
        let hasFired = false;
        // Function to call when new <hypothesis-highlight> elements are added
        function handleNewHighlights() {
            if (!hasFired) {
                // Check if the function has not been called yet
                const highlights = document.querySelectorAll(
                    "hypothesis-highlight",
                );
                highlights.forEach((highlight) => {
                    console.log("New highlight added:", highlight);
                    annotationsArrayPromise.then((annotationsArray) => {
                        addTooltips(annotationsArray);
                    });
                });

                hasFired = true;
            }
        }

        // Set up MutationObserver
        const observer = new MutationObserver((mutationsList) => {
            for (const mutation of mutationsList) {
                if (mutation.type === "childList") {
                    // Check for added nodes
                    mutation.addedNodes.forEach((node) => {
                        if (
                            node.nodeType === Node.ELEMENT_NODE &&
                            node.tagName.toLowerCase() ===
                                "hypothesis-highlight"
                        ) {
                            handleNewHighlights();
                        }
                    });
                }
            }
        });

        // Start observing the container where elements get added
        const dynamicContainer = document.getElementById("main");

        // Check if the target node is available
        if (dynamicContainer) {
            observer.observe(dynamicContainer, {
                childList: true, // Observe direct children
                subtree: true, // Observe all descendants (if needed)
            });
        } else {
            console.error("Target node for observer not found.");
        }
    });
</script>

<style>
    .highlighted {
        position: relative;
        cursor: pointer;
    }

    .tooltip {
        display: none; /* Default hidden until hovered */
        position: absolute;
        background-color: #333;
        color: #fff;
        padding: 5px;
        border-radius: 5px;
        z-index: 1000; /* Ensure it's on top */
        white-space: nowrap; /* Prevent line break */
        font-size: 1rem;
    }

    .text-px-base,
    div[data-testid="sidebar-edge"],
    div[data-component="Button"] {
        display: none !important;
        visibility: hidden !important;
    }
</style>
