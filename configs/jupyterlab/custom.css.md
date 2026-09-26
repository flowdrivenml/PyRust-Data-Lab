:root {
  --jp-layout-color0: #1a1b26 !important;
  --jp-layout-color1: #1f2335 !important;
  --jp-layout-color2: #24283b !important;
  --jp-layout-color3: #292e42 !important;
  --jp-layout-color4: #343b58 !important;

  --jp-ui-font-color0: #c0caf5 !important;
  --jp-ui-font-color1: #a9b1d6 !important;
  --jp-ui-font-color2: #787c99 !important;
  --jp-ui-font-color3: #565f89 !important;
  --jp-content-font-color0: #c0caf5 !important;
  --jp-content-font-color1: #a9b1d6 !important;
  --jp-content-font-color2: #787c99 !important;
  --jp-content-font-color3: #565f89 !important;

  --jp-border-color0: #565f89 !important;
  --jp-border-color1: #414868 !important;
  --jp-border-color2: #343b58 !important;
  --jp-border-color3: #292e42 !important;

  --jp-brand-color0: #bb9af7 !important;
  --jp-brand-color1: #9d7cd8 !important;
  --jp-brand-color2: #7e6aa6 !important;
  --jp-brand-color3: #56526e !important;
  --jp-accent-color0: #ff77aa !important;
  --jp-accent-color1: #f7768e !important;
  --jp-accent-color2: #e0af68 !important;
  --jp-accent-color3: #9ece6a !important;

  --jp-cell-editor-background: #16161e !important;
  --jp-cell-editor-border-color: #414868 !important;
  --jp-cell-editor-active-background: #1a1b26 !important;
  --jp-cell-editor-active-border-color: #ff77aa !important;
  --jp-cell-prompt-active-font-color: #ff77aa !important;
  --jp-cell-prompt-not-active-font-color: #787c99 !important;
  --jp-notebook-select-background: #24283b !important;
  --jp-notebook-multiselected-color: rgba(255, 119, 170, 0.18) !important;

  --jp-content-link-color: #7aa2f7 !important;
  --jp-success-color0: #9ece6a !important;
  --jp-warn-color0: #e0af68 !important;
  --jp-error-color0: #f7768e !important;
  --jp-info-color0: #7dcfff !important;

  --jp-code-font-family: "JetBrains Mono", "Fira Code", monospace !important;
  --jp-ui-font-family: Inter, "Noto Sans", sans-serif !important;
  --jp-content-font-family: Inter, "Noto Sans", sans-serif !important;

  --jp-mirror-editor-keyword-color: #ff55aa !important;
  --jp-mirror-editor-atom-color: #bb9af7 !important;
  --jp-mirror-editor-number-color: #ff9e64 !important;
  --jp-mirror-editor-def-color: #ff66aa !important;
  --jp-mirror-editor-variable-color: #c0caf5 !important;
  --jp-mirror-editor-variable-2-color: #7aa2f7 !important;
  --jp-mirror-editor-variable-3-color: #ff99cc !important;
  --jp-mirror-editor-punctuation-color: #89ddff !important;
  --jp-mirror-editor-property-color: #ff99cc !important;
  --jp-mirror-editor-operator-color: #89ddff !important;
  --jp-mirror-editor-comment-color: #ff88cc !important;
  --jp-mirror-editor-string-color: #9ece6a !important;
  --jp-mirror-editor-builtin-color: #7dcfff !important;
  --jp-mirror-editor-tag-color: #f7768e !important;
  --jp-mirror-editor-attribute-color: #bb9af7 !important;
  --jp-mirror-editor-header-color: #7aa2f7 !important;
  --jp-mirror-editor-quote-color: #9ece6a !important;
  --jp-mirror-editor-link-color: #7aa2f7 !important;
  --jp-mirror-editor-error-color: #f7768e !important;
}

body,
.jp-LabShell,
.jp-MainAreaWidget,
.jp-SideBar-content,
.jp-FileBrowser,
.jp-FileBrowser-Panel,
.jp-DirListing-content,
.lm-DockPanel,
.lm-StackedPanel {
  background: #1a1b26 !important;
  color: #c0caf5 !important;
}

#jp-MainMenu,
#menu-panel-wrapper,
#top-panel-wrapper,
.jp-TopPanel,
.jp-Toolbar,
.jp-NotebookPanel-toolbar,
.jp-StatusBar {
  background: #1f2335 !important;
  color: #c0caf5 !important;
  border-color: #343b58 !important;
}

.jp-FileBrowser .jp-Toolbar,
.jp-FileBrowser-toolbar {
  background: #1f2335 !important;
}

.jp-DirListing-item {
  color: #a9b1d6 !important;
  border-radius: 5px;
}

.jp-DirListing-item:hover {
  background: #292e42 !important;
  color: #c0caf5 !important;
}

.jp-DirListing-item.jp-mod-selected {
  background: rgba(187, 154, 247, 0.2) !important;
  color: #ff99cc !important;
}

.lm-TabBar,
.lm-TabBar-content,
.lm-TabBar-tab {
  background: #1f2335 !important;
  color: #a9b1d6 !important;
}

.lm-TabBar-tab.jp-mod-current {
  background: #1a1b26 !important;
  color: #c0caf5 !important;
  box-shadow: inset 0 -2px #ff77aa;
}

.lm-Menu,
.jp-Menu {
  background: #24283b !important;
  color: #c0caf5 !important;
  border: 1px solid #565f89 !important;
}

.lm-Menu-item:hover,
.lm-Menu-item.jp-mod-active {
  background: #343b58 !important;
}

.jp-Notebook {
  background: #1a1b26 !important;
}

.jp-Notebook .jp-InputArea-editor {
  background: #16161e !important;
  border: 1px solid #343b58 !important;
  border-radius: 6px;
}

.jp-Notebook .jp-mod-active .jp-InputArea-editor {
  border-color: #bb9af7 !important;
  box-shadow: 0 0 0 1px rgba(187, 154, 247, 0.22);
}

.jp-Notebook .jp-InputPrompt {
  color: #ff77aa !important;
}

.jp-Notebook .jp-OutputPrompt {
  color: #7dcfff !important;
}

.jp-RenderedHTMLCommon h1,
.jp-RenderedHTMLCommon h2,
.jp-RenderedHTMLCommon h3 {
  color: #bb9af7 !important;
}

.jp-RenderedHTMLCommon a {
  color: #7aa2f7 !important;
}

.jp-RenderedHTMLCommon code {
  color: #ff77aa !important;
  background: #24283b !important;
  border-radius: 4px;
}

::selection {
  background: rgba(255, 119, 170, 0.32);
}