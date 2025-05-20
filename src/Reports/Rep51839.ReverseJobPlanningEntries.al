report 51839 "Reverse Job Planning Entries"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Control4)
                {
                    ShowCaption = false;

                    field("Job No."; JobNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Job No. ';
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field(JobTask; JobTask)
                    {
                        ApplicationArea = All;
                        Caption = 'Job Task No. ';

                        trigger OnLookup(var Text: Text): Boolean begin
                            JobTask_rec.RESET;
                            JobTask_rec.SETRANGE("Job No.", JobNo);
                            JobTask_rec.SETFILTER("Job Task No.", '<>%1', '');
                            JobTask_rec.SETFILTER("Job Task Type", '%1', JobTask_rec."Job Task Type"::Posting);
                            IF PAGE.RUNMODAL(PAGE::"Job Task Lines", JobTask_rec) = ACTION::LookupOK THEN BEGIN
                                JobTask:=JobTask_rec."Job Task No.";
                            END;
                        end;
                    }
                    field("Line No."; LineNo)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean begin
                            JobPlanningLine.RESET;
                            JobPlanningLine.SETRANGE("Job No.", JobNo);
                            JobPlanningLine.SETRANGE("Job Task No.", JobTask);
                            JobPlanningLine.SETRANGE(Reversed, FALSE);
                            JobPlanningLine.SETRANGE("Line Type", JobPlanningLine."Line Type"::Budget);
                            JobPlanningLine.SETFILTER(Quantity, '>%1', 0);
                            JobPlanningLine.SETFILTER(Type, '<>%1', JobPlanningLine.Type::Text);
                            IF PAGE.RUNMODAL(PAGE::"Job Planning Lines", JobPlanningLine) = ACTION::LookupOK THEN BEGIN
                                LineNo:=FORMAT(JobPlanningLine."Line No.");
                                Description:=JobPlanningLine.Description;
                            END;
                        end;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        OEE_Requisitions."Reverse Job Planning Entry"(JobNo, JobTask, LineNo);
    end;
    var JobNo: Code[20];
    JobTask: Code[20];
    LineNo: Code[10];
    Description: Text[100];
    JobTask_rec: Record "Job Task";
    JobPlanningLine: Record "Job Planning Line";
    OEE_Requisitions: Codeunit 51805;
    procedure GetJobNo(var Job: Record Job)
    begin
        JobNo:=Job."No.";
        JobTask:='';
        LineNo:='';
        Description:='';
    end;
}
