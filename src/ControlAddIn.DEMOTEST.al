controladdin "DEMOTEST"
{
    RequestedHeight = 300;
    RequestedWidth = 300;
    MaximumHeight = 300;
    //requestedwidth = 700;
    // MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalShrink = true;
    HorizontalShrink = true;
    VerticalStretch = true;
    HorizontalStretch = true;
    Scripts = 'JsScript/demo.js';
    StyleSheets = 'Stylesheet/Stylesheet.css';
    StartupScript = 'JsScript/Start.js';

    //RecreateScript = 'RecreateScript.js';
    //RefreshScript = 'RefreshScript.js';
    //Images = 'image1.png',
    //        'image2.png';
    event Ready()procedure Myprocedure()
}
