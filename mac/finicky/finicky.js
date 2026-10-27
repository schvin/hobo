// ~/.finicky.js -> hobo/mac/finicky/finicky.js
// Finicky is the macOS default browser; it forwards every link by these rules.
// Docs: https://github.com/johnste/finicky/wiki/Configuration-(v4)
//
// Choose at click time (works from ghostty cmd+click, Slack, Mail, …):
//   hold option  -> Firefox Developer Edition
//   hold shift   -> Chrome Canary
//   hold fn      -> Safari
// In tmux, prefix-u then ctrl-b gives a full picker.

const ZEN = "app.zen-browser.zen";
const FIREFOX = "org.mozilla.firefoxdeveloperedition";
const CHROME = "com.google.Chrome.canary";
const SAFARI = "com.apple.Safari";

export default {
  defaultBrowser: ZEN,

  options: {
    checkForUpdates: true,
    logRequests: false,
  },

  rewrite: [
    // strip common tracking params everywhere
    {
      match: () => true,
      url: (url) => {
        for (const p of [...url.searchParams.keys()]) {
          if (/^(utm_|fbclid$|gclid$|mc_eid$|igshid$)/.test(p)) url.searchParams.delete(p);
        }
        return url;
      },
    },
  ],

  handlers: [
    // --- modifier overrides (checked first) ------------------------------
    { match: () => finicky.getModifierKeys().option, browser: FIREFOX },
    { match: () => finicky.getModifierKeys().shift, browser: CHROME },
    { match: () => finicky.getModifierKeys().fn, browser: SAFARI },

    // --- rules: edit these ------------------------------------------------
    // glob:   "*.example.com/*"
    // regex:  /^https?:\/\/[^/]*\.corp\.example\.com\//
    // fn:     (url, { opener }) => opener?.bundleId === "com.tinyspeck.slackmacgap"
    {
      // work SSO / admin consoles in Chrome
      match: [
        /^https?:\/\/([^/]+\.)?okta\.com\//,
        /^https?:\/\/([^/]+\.)?duosecurity\.com\//,
        /^https?:\/\/(console\.aws\.amazon\.com|portal\.azure\.com|console\.cloud\.google\.com)\//,
        "meet.google.com/*",
      ],
      browser: CHROME,
    },
    {
      // dev servers in Firefox Developer Edition
      match: [/^https?:\/\/(localhost|127\.0\.0\.1|\[::1\]|[^/]+\.(test|local))(:\d+)?\//],
      browser: FIREFOX,
    },
    {
      // Apple stuff behaves best in Safari
      match: finicky.matchHostnames(["*.apple.com", "icloud.com", "*.icloud.com"]),
      browser: SAFARI,
    },
  ],
};
