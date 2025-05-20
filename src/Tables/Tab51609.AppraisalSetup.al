table 51609 "Appraisal Setup"
{
    fields
    {
        field(1; "Review Start Date"; Date)
        {
        }
        field(2; "Review End Date"; Date)
        {
        }
        field(3; "Due Date for Appraisees"; Date)
        {
        }
        field(4; "Due Date for Appraisers"; Date)
        {
        }
        field(5; Activated; Boolean)
        {
            trigger OnValidate()
            begin
                if(xRec.Activated <> Activated)then if Activated = true then begin
                        TestField("Due Date for Appraisees");
                        TestField("Due Date for Appraisers");
                        //Test Review Period validity
                        if "Review Start Date" > Today then Error(Text000, FieldCaption("Review Start Date"));
                        if("Review End Date" > Today)then Error(Text000, FieldCaption("Review End Date"));
                        //
                        Setup.Reset;
                        Setup.SetFilter("Review Start Date", '<>%1', "Review Start Date");
                        Setup.SetFilter("Review End Date", '<>%1', "Review End Date");
                        if Setup.Find('-')then begin
                            repeat Setup.Activated:=false;
                                Setup.Modify;
                            until Setup.Next = 0;
                        end;
                    end;
            end;
        }
        field(6; "Activated By"; Code[50])
        {
        }
        field(7; "Deactivayted By"; Code[50])
        {
        }
    }
    keys
    {
        key(Key1; "Review Start Date", "Review End Date")
        {
        }
        key(Key2; Activated)
        {
        }
    }
    fieldgroups
    {
    }
    var Setup: Record "Appraisal Setup";
    Text000: Label 'The period under review cannot be ahead. Kindly change the %1';
}
