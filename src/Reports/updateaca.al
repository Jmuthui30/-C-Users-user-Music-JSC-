report 53070 "update quo code"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Qualification; Qualification)
        {
            RequestFilterFields = Code;
            column(Code; Code)
            {

            }
            trigger OnAfterGetRecord()
            begin
                AppQ.Reset();
                AppQ.SetRange(AppQ."Qualification Code", Code);
                if AppQ.Find('-') then begin
                    repeat
                        AppQ.Description := Description;
                        AppQ.Modify()
                    until AppQ.Next() = 0;
                end;
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {

            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    }

    var
        myInt: Integer;
        AppQ: Record "Applicants Qualification";
}