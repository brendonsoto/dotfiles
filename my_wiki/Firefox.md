# Firefox
## Problems and Solutions
P: Nightly won't connect to HTTPS sites (like youtube or startpage)
S: In Nightly...
1. Open a new tab
2. Navigate to `about:config`
3. Search for `security.enterprise_roots.enabled`
4. Set it to *True*
5. Restart Nightly
More Info: https://wiki.mozilla.org/CA/AddRootToFirefox
