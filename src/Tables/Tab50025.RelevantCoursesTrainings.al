table 50025 "Relevant Courses & Trainings"
{
    fields
    {
        field(1; "Source No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Name of the Course"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "University/College/Institution"; Text[1000])
        {
        }
        field(4; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
                If (("From Date" <> 0D) and ("To Date" <> 0D)) then Duration := Dates.DetermineDatesDiffrence("From Date", "To Date");
                // if "To Date" <= "From Date" then
                //    Error(Error001, "To Date", "From Date");
            end;
        }
        field(5; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
                // if "To Date" <= "From Date" then
                //     Error(Error001, "To Date", "From Date");
                // Validate("From Date");
                Duration := Dates.DetermineDatesDiffrence("From Date", "To Date");
            end;

        }
        field(6; Duration; Text[50])
        {
            Editable = false;
        }
        field(7; "Attachment Link"; Text[1250])
        {
        }
        field(8; "Line No"; Integer)
        {

        }
    }
    keys
    {
        key(Key1; "Source No", "Name of the Course")
        {
            Clustered = true;
        }
    }
    var
        Dates: Codeunit "HR Dates Mgt";
}
