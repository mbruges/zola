
<!-- <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.classless.min.css"> -->
    
<style>

hypothesis-highlight, .highlight-link {
    background-color: rgba(var(--a), 0.5);
    background-color: color-mix(in srgb, var(--a), transparent 70%);
    border-radius: var(--border-radius);
    font-family: sans-serif !important;
    text-decoration: none !important;
    color:var(--t) !important;
    padding-left:0.2em;
    padding-right:0.2em;
    margin-left: -0.2em;
    margin-right: -0.2em;
}

/**
 * Tooltip ([data-tooltip])
 */
 
[data-tooltip] {
  position: relative;
}
[data-tooltip]:not(a, button, input) {
  border-bottom: 1px dotted;
  text-decoration: none;
  cursor: help;
}
[data-tooltip][data-placement=top]::before, [data-tooltip][data-placement=top]::after, [data-tooltip]::before, [data-tooltip]::after {
  display: block;
  z-index: 99;
  position: absolute;
  bottom: 100%;
  left: 50%;
  padding: 0.25rem 0.5rem;
  overflow: hidden;
  transform: translate(-50%, -0.25rem);
  border-radius: var(--border-radius);
  background: var(--t);
  content: attr(data-tooltip);
  color: var(--b);
  font-style: normal;
  font-size: 0.875rem;
  text-decoration: none;
  text-overflow: ellipsis;
  white-space: nowrap;
  opacity: 0;
  pointer-events: none;
}

[data-tooltip][data-placement=top]::after, [data-tooltip]::after {
  padding: 0;
  transform: translate(-50%, 0rem);
  border-top: 0.3rem solid;
  border-right: 0.3rem solid transparent;
  border-left: 0.3rem solid transparent;
  border-radius: 0;
  background-color: transparent;
  content: "";
  color: var(--t);
}
[data-tooltip][data-placement=bottom]::before, [data-tooltip][data-placement=bottom]::after {
  top: 100%;
  bottom: auto;
  transform: translate(-50%, 0.25rem);
}
[data-tooltip][data-placement=bottom]:after {
  transform: translate(-50%, -0.3rem);
  border: 0.3rem solid transparent;
  border-bottom: 0.3rem solid;
}
[data-tooltip][data-placement=left]::before, [data-tooltip][data-placement=left]::after {
  top: 50%;
  right: 100%;
  bottom: auto;
  left: auto;
  transform: translate(-0.25rem, -50%);
}
[data-tooltip][data-placement=left]:after {
  transform: translate(0.3rem, -50%);
  border: 0.3rem solid transparent;
  border-left: 0.3rem solid;
}
[data-tooltip][data-placement=right]::before, [data-tooltip][data-placement=right]::after {
  top: 50%;
  right: auto;
  bottom: auto;
  left: 100%;
  transform: translate(0.25rem, -50%);
}
[data-tooltip][data-placement=right]:after {
  transform: translate(-0.3rem, -50%);
  border: 0.3rem solid transparent;
  border-right: 0.3rem solid;
}
[data-tooltip]:focus::before, [data-tooltip]:focus::after, [data-tooltip]:hover::before, [data-tooltip]:hover::after {
  opacity: 1;
}
@media (hover: hover) and (pointer: fine) {
  [data-tooltip]:focus::before, [data-tooltip]:focus::after, [data-tooltip]:hover::before, [data-tooltip]:hover::after {
    --pico-tooltip-slide-to: translate(-50%, -0.25rem);
    transform: translate(-50%, 0.75rem);
    animation-duration: 0.2s;
    animation-fill-mode: forwards;
    animation-name: tooltip-slide;
    opacity: 0;
  }
  [data-tooltip]:focus::after, [data-tooltip]:hover::after {
    --pico-tooltip-caret-slide-to: translate(-50%, 0rem);
    transform: translate(-50%, -0.25rem);
    animation-name: tooltip-caret-slide;
  }
}
@keyframes tooltip-slide {
  to {
    transform: var(--pico-tooltip-slide-to);
    opacity: 1;
  }
}
@keyframes tooltip-caret-slide {
  50% {
    opacity: 0;
  }
  to {
    transform: var(--pico-tooltip-caret-slide-to);
    opacity: 1;
  }
}

</style>
 
<script>
var annotationsArray = ["none"]

    function deleteHypothesisApps() {
      console.log('attempting to delete apps')
      elements = ['hypothesis-sidebar','hypothesis-notebook','hypothesis-profile','hypothesis-adder','hypothesis-highlight-cluster-toolbar']
      elements.forEach((elem) => {
        const tags = document.getElementsByTagName(elem);
        while (tags.length > 0) {
          tags[0].parentNode.removeChild(tags[0]);
        }
      });
    }
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
            annotationsArray = data.rows
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
            annotationsArray;
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
            showHighlights: "never",
        };
    };
    document.addEventListener("DOMContentLoaded", () => {
        let hasFired = false;
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
                          console.log(node)
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
    
 function showHighlightTags(){
   console.log("attempting to load tags")
   //delaying to account for all highlights
   setTimeout(() => {
      const highlightsArray = Array.from(document.querySelectorAll("hypothesis-highlight"));
      console.log("Hypothesis highlights loaded");
      deleteHypothesisApps()
      highlightsArray.forEach((highlight, index) => {
          const annotation = annotationsArray[index]; // Assuming order matches
          console.log(annotation);
          if (annotation) {
              console.log("annotation added");
              let tooltip = document.createElement("div");
              cleanAnnotation = annotation.annotationText.replace(/\n/g, ' ').replace(/\s+/g, ' ').trim();
              tooltip.className = "tooltip";
              tooltip.textContent = cleanAnnotation;
              // highlight.setAttribute('tooltip-data', cleanAnnotation);
              highlight.innerHTML = `<a href="#" class="highlight-link" data-tooltip="${cleanAnnotation}">${highlight.innerText}</a>`;
              // highlight.addEventListener("mouseenter", () => {
              //     console.log("mousedover");
              //     tooltip.style.display = "block";
              //     const rect = highlight.getBoundingClientRect();
              //     tooltip.style.left = `${rect.left + window.scrollX}px`;
              //     tooltip.style.top = `${rect.top + window.scrollY - tooltip.offsetHeight - 5}px`;
              // });
    
              // highlight.addEventListener("mouseleave", () => {
              //     tooltip.style.display = "none";
              // });
          }
      });
      }, 1000);
 }

  document.addEventListener("DOMContentLoaded", () => {
      const observer = new MutationObserver((mutationsList) => {
          for (const mutation of mutationsList) {
            
              if (mutation.addedNodes.length) {
                  mutation.addedNodes.forEach((node) => {
                    if ((node.tagName) && (node.tagName == ("HYPOTHESIS-HIGHLIGHT"))){
                      // console.log("mutation detected, checking if h-a: " + node.tagName)
                      showHighlightTags()
                      observer.disconnect();
                    }
                  });
              }
          }
      });
      const body = document.body;
      observer.observe(body, { childList: true, subtree: true });
  })
 

function loadTooltips() {
  console.log("loading tooltips...")
    // Create a tooltip element
    const tooltip = document.createElement("div");
    tooltip.className = "tooltip";
    document.body.appendChild(tooltip);

    const highlights = document.querySelectorAll('.hypothesis-highlight');

    highlights.forEach(highlight => {
        highlight.addEventListener('mouseenter', function (e) {
            const tooltipData = this.getAttribute('data-tooltip');
            tooltip.textContent = tooltipData; // Set tooltip text
            tooltip.style.visibility = 'visible'; // Make it visible
            
            // Position the tooltip based on the mouse position
            tooltip.style.left = `${e.pageX + 10}px`; // Slight offset from mouse
            tooltip.style.top = `${e.pageY + 10}px`;
        });

        highlight.addEventListener('mousemove', function (e) {
            // Update tooltip position as mouse moves
            tooltip.style.left = `${e.pageX + 10}px`;
            tooltip.style.top = `${e.pageY + 10}px`;
        });

        highlight.addEventListener('mouseleave', function () {
            tooltip.style.visibility = 'hidden'; // Hide tooltip
        });
    });
}
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
