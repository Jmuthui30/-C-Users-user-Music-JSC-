report 52929 "Update Doc"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/updatedoc.rdl';

    dataset
    {
        dataitem("SharePoint Intergration"; "SharePoint Intergration")
        {
            requestFilterFields = "Document No", "Entry No";
            column(Document_No; "Document No")
            {

            }
            trigger OnAfterGetRecord()
            begin
                // if "SharePoint Intergration".Get("Document No") then begin

                if "SharePoint Intergration".SP_URL_Returned = '' then begin
                    "SharePoint Intergration".Polled := false;
                    "SharePoint Intergration".Modify();
                end
                // end;
            end;
        }
    }



}