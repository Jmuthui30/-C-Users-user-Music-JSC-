controladdin "PDF Viewer"
{
    Scripts = 'https://ajax.aspnetcdn.com/ajax.jQuery/jquery-3.3.1.min.js', 'https://cloudflare.com/ajax/libs/pdf.js/2.8.335/pdf.min.js', 'JsScript/script.js';
    StartupScript = 'JsScript/start.js';
    StyleSheets = 'stylesheet/stylesheet.css';
    MinimumHeight = 1;
    MinimumWidth = 1;
    MaximumHeight = 2000;
    HorizontalStretch = true;
    VerticalStretch = true;

    event controlAddinReady();
    event onView();
    procedure LoadPDF(pdfDocument: text; isfactbox: boolean)procedure setVisible(isVisible: Boolean)
}
