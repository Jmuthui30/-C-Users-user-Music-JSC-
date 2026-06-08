page 52209 "Training participants"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Participants";
    UsageCategory = Lists;
    Caption = 'Training participants';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Training Need"; Rec."Training Need")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Training Need field';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Employee Email"; GetEmployeeEmail())
                {
                    ApplicationArea = All;
                    Caption = 'Employee Email';
                    Editable = false;
                    ToolTip = 'Specifies the email address that will be used for training notifications.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.GetFilter("Training Need") <> '' then
            Rec."Training Need" := Rec.GetRangeMin("Training Need");
    end;

    local procedure GetEmployeeEmail(): Text
    var
        Employee: Record Employee;
    begin
        if not Employee.Get(Rec."Employee No") then
            exit('');

        if Employee."Company E-Mail" <> '' then
            exit(Employee."Company E-Mail");

        exit(Employee."E-Mail");
    end;
}





