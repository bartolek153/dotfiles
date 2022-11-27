return {

    -- Disable PYRIGHT diagnostics to priorize linters (null-ls)
    handlers = {
        ['textDocument/publishDiagnostics'] = function(...) end
    },

    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
}
