!(function () {
  "use strict";
  console.log("running annotations.js");
  var s = {
    "scripts/annotator.bundle.js": "scripts/annotator.bundle.js?c1ec38",
    "styles/annotator.css": "styles/annotator.css?4a2cb6",
    "styles/annotator.css.map": "styles/annotator.css.map?969663",
    "styles/highlights.css": "styles/highlights.css?6b4ebd",
    "styles/highlights.css.map": "styles/highlights.css.map?241350",
    "styles/katex.min.css": "styles/katex.min.css?94f096",
    "styles/katex.min.css.map": "styles/katex.min.css.map?e7e03f",
    "styles/pdfjs-overrides.css": "styles/pdfjs-overrides.css?c95edf",
    "styles/pdfjs-overrides.css.map": "styles/pdfjs-overrides.css.map?1d8ac6",
    // "styles/sidebar.css": "styles/sidebar.css?3278f7",
    // "styles/sidebar.css.map": "styles/sidebar.css.map?6c7cc4",
    "styles/ui-playground.css": "styles/ui-playground.css?fabf66",
    "styles/ui-playground.css.map": "styles/ui-playground.css.map?057ae3",
    "scripts/annotator.bundle.js.map": "scripts/annotator.bundle.js.map?b7dc0f",
    // "scripts/sidebar.bundle.js": "scripts/sidebar.bundle.js?62e729",
    "scripts/ui-playground.bundle.js": "scripts/ui-playground.bundle.js?e9e4b6",
    "scripts/ui-playground.bundle.js.map":
      "scripts/ui-playground.bundle.js.map?e91bdd",
    // "scripts/sidebar.bundle.js.map": "scripts/sidebar.bundle.js.map?ed10a4",
  };
  function e(s) {
    s.setAttribute("data-hypothesis-asset", "");
  }
  function t(s, t) {
    var o = s.createElement("link");
    (o.rel = "stylesheet"),
      (o.type = "text/css"),
      (o.href = t),
      e(o),
      s.head.appendChild(o);
  }
  function o(s, t) {
    var o = arguments.length > 2 && void 0 !== arguments[2] ? arguments[2] : {},
      r = o.esModule,
      n = void 0 === r || r,
      i = o.forceReload,
      a = void 0 !== i && i,
      l = s.createElement("script");
    n && (l.type = "module"),
      a && (t += "#ts=".concat(Date.now())),
      (l.src = t),
      (l.async = !1),
      e(l),
      s.head.appendChild(l);
  }
  function r(s, t, o, r) {
    var n = s.createElement("link");
    (n.rel = t),
      (n.href = r),
      (n.type = "application/annotator+".concat(o)),
      e(n),
      s.head.appendChild(n);
  }
  function n(s, t, o) {
    var r = s.createElement("link");
    (r.rel = "preload"),
      (r.as = t),
      (r.href = o),
      "fetch" === t && (r.crossOrigin = "anonymous"),
      e(r),
      s.head.appendChild(r);
  }
  function i(s, e) {
    return s.assetRoot + "build/" + s.manifest[e];
  }
  function a(s) {
    var e =
      arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : document;
    if (-1 === s.indexOf("{")) return s;
    var t = (function () {
      var s,
        e,
        t = (
          arguments.length > 0 && void 0 !== arguments[0]
            ? arguments[0]
            : document
        ).currentScript;
      return t
        ? ((s = t.src),
          (e = s.match(/(https?):\/\/([^:/]+)/))
            ? { protocol: e[1], hostname: e[2] }
            : null)
        : null;
    })(e);
    if (!t)
      throw new Error(
        "Could not process URL template because script origin is unknown",
      );
    return (s = (s = s.replace("{current_host}", t.hostname)).replace(
      "{current_scheme}",
      t.protocol,
    ));
  }
  if (
    (function () {
      var s = [
        () => Object.fromEntries([]),
        () => new URL(document.location.href),
        () => new Request("https://hypothes.is"),
        () => Element.prototype.attachShadow,
        () => CSS.supports("display: grid"),
        () => (
          document.evaluate(
            "/html/body",
            document,
            null,
            XPathResult.ANY_TYPE,
            null,
          ),
          !0
        ),
      ];
      try {
        return s.every((s) => s());
      } catch (s) {
        return !1;
      }
    })()
  ) {
    var l = (function (s) {
        for (
          var e = {},
            t = s.querySelectorAll("script.js-hypothesis-config"),
            o = 0;
          o < t.length;
          o++
        ) {
          var r = void 0;
          try {
            r = JSON.parse(t[o].textContent || "");
          } catch (s) {
            console.warn(
              "Could not parse settings from js-hypothesis-config tags",
              s,
            ),
              (r = {});
          }
          Object.assign(e, r);
        }
        return e;
      })(document),
      p = a(l.assetRoot || "https://cdn.hypothes.is/hypothesis/1.1551.0/");
    if (document.querySelector("hypothesis-app")) {
      !(function (s, e) {
        n(s, "fetch", e.apiUrl), n(s, "fetch", e.apiUrl + "links");
        // for (var r = 0, a = ["scripts/sidebar.bundle.js"]; r < a.length; r++)
        //   o(s, i(e, a[r]), { esModule: !0 });
        // for (
        //   var l = 0, p = ["styles/katex.min.css", "styles/sidebar.css"];
        //   l < p.length;
        //   l++
        // )
        t(s, i(e, p[l]));
      })(document, { assetRoot: p, manifest: s, apiUrl: l.apiUrl });
    } else {
      var c = (function () {
        var s;
        return null ===
          (s = (
            arguments.length > 0 && void 0 !== arguments[0]
              ? arguments[0]
              : window
          ).chrome) ||
          void 0 === s ||
          null === (s = s.runtime) ||
          void 0 === s
          ? void 0
          : s.id;
      })();
      if (
        c &&
        !(function (s) {
          return !!(
            arguments.length > 1 && void 0 !== arguments[1]
              ? arguments[1]
              : document
          ).querySelector(
            "script.js-hypothesis-config[data-extension-id=".concat(s, "]"),
          );
        })(c)
      )
        throw new Error(
          "Could not start Hypothesis extension as configuration is missing",
        );
      var d = l,
        h = a(d.notebookAppUrl || "https://hypothes.is/notebook"),
        u = a(d.profileAppUrl || "https://hypothes.is/user-profile"),
        y = a(d.sidebarAppUrl || "https://hypothes.is/app.html");
      !(function (s, e) {
        if (!s.querySelector('link[type="application/annotator+html"]')) {
          r(s, "sidebar", "html", e.sidebarAppUrl),
            r(s, "notebook", "html", e.notebookAppUrl),
            r(s, "profile", "html", e.profileAppUrl),
            n(s, "style", i(e, "styles/annotator.css")),
            r(
              s,
              "hypothesis-client",
              "javascript",
              e.assetRoot + "build/boot.js",
            );
          for (
            var a = 0, l = ["scripts/annotator.bundle.js"];
            a < l.length;
            a++
          )
            o(s, i(e, l[a]), { esModule: !1 });
          var p = [];
          void 0 !== window.PDFViewerApplication &&
            p.push("styles/pdfjs-overrides.css"),
            p.push("styles/highlights.css");
          for (var c = 0, d = p; c < d.length; c++) t(s, i(e, d[c]));
        }
      })(document, {
        assetRoot: p,
        manifest: s,
        notebookAppUrl: h,
        profileAppUrl: u,
        sidebarAppUrl: y,
      });
    }
  } else
    console.warn(
      "The Hypothesis annotation tool is not supported in this browser. See https://web.hypothes.is/help/which-browsers-are-supported-by-hypothesis/.",
    );
})();
