require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
    prefer_multi_line_comments = false,
})

require('kommentary.config').configure_language("nix", {
    single_line_comment_string = "#",
    multi_line_comment_strings = {"/*", "*/"},
})
