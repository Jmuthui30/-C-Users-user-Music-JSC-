table 51616 "Appraisal Rating"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Appraisal Rating";
    LookupPageID = "Appraisal Rating";

    fields
    {
        field(1; Rating; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Score; Decimal)
        {
        }
        field(4; "Total Possible Score"; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; Rating)
        {
        }
    }
    fieldgroups
    {
    }
}
