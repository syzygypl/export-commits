export const diffTemplate = (diff: string, author: string): string => {
    return `<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Diff by ${author}</title>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/diff2html/bundles/js/diff2html-ui.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/styles/github.min.css">  
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/diff2html/bundles/css/diff2html.min.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/highlight.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/languages/scala.min.js"></script>
    
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const targetElement = document.getElementById('diff');
                const diff2htmlUi = new Diff2HtmlUI(targetElement);
                diff2htmlUi.synchronisedScroll("#diff", false);
                diff2htmlUi.highlightCode('#diff');
                diff2htmlUi.fileListToggle(true);
            });
        </script>
    </head>
    <body style="text-align: center; font-family: 'Source Sans Pro',sans-serif;">
        <h1>Diff by ${author}</h1>
        <div id="diff">
            ${diff}
        </div>
        
        <span style="font-size: 12px">Diff to HTML by <a href="https://github.com/bogusweb">Pawel Boguslawski</a> & <a href="https://github.com/adamkrupa-syzygy">Adam Krupa</a></span>
    </body>
</html>`
}