report 53070 "update quo code"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Applupdate;

    dataset
    {
        //"Applicant Professional Bodies"
        dataitem("Recruitment Needs"; "Recruitment Needs")
        {
            // RequestFilterFields = "Qualification Type", Code;
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                AppQ.Reset();
                AppQ.SetRange(AppQ."Recruitment Needs No.", "No.");
                if AppQ.Find('-') then begin

                    repeat
                        AppQ."Closed Date" := "End Date";
                        AppQ.Modify()
                                         until AppQ.Next() = 0;



                end;
                //*******************************************************************************


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
        layout(Applupdate)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/update quo code.RDLC';
            Caption = 'Job Submitted';
        }
    }

    var
        myInt: Integer;
        AppQ: Record "Job Application";


        JobApplication: record "Job Application";
}