page 52109 "DSA Rates"
{
    ApplicationArea = All;
    Caption = 'Grades Scale Rates';
    PageType = List;
    SourceTable = "DSA Rates";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Group"; Rec."Job Group")
                {
                    ToolTip = 'Specifies the value of the Job Group field.', Comment = '%';
                }
                field(Rates; Rec.Rates)
                {
                    ToolTip = 'Specifies the value of the Rates field.', Comment = '%';
                }
                field(DSA; Rec.DSA)
                {
                    ToolTip = 'Specifies the value of the DSA field.', Comment = '%';
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                    ToolTip = 'Specifies the value of the Air Ticket field.', Comment = '%';
                }
                field(Conference; Rec.Conference)
                {
                    ToolTip = 'Specifies the value of the Conference field.', Comment = '%';
                }
                field("Ground Transport"; Rec."Ground Transport")
                {
                    ToolTip = 'Specifies the value of the Ground Transport field.', Comment = '%';
                }
                field("Cordination Allowance"; Rec."Cordination Allowance")
                {
                    ToolTip = 'Specifies the value of the Cordination Allowance field.', Comment = '%';
                }
                field("Facilitator Allowance"; Rec."Facilitator Allowance")
                {
                    ToolTip = 'Specifies the value of the Facilitator Allowance field.', Comment = '%';
                }
                field("Secretariat Allowance"; Rec."Secretariat Allowance")
                {
                    ToolTip = 'Specifies the value of the Secretariat Allowance field.', Comment = '%';
                }
                field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance")
                {
                    ToolTip = 'Specifies the value of the Out of Pocket Allowance field.', Comment = '%';
                }
                field("Rapporteur Allowance"; Rec."Rapporteur Allowance")
                {
                    ToolTip = 'Specifies the value of the Rapporteur Allowance field.', Comment = '%';
                }
                field("Driver Allowance"; Rec."Driver Allowance")
                {
                    ToolTip = 'Specifies the value of the Driver Allowance field.', Comment = '%';
                }
                field("Retreat Allowance"; Rec."Retreat Allowance")
                {
                    ToolTip = 'Specifies the value of the Retreat Allowance field.', Comment = '%';
                }
                field("Expert Allowance"; Rec."Expert Allowance")
                {
                    ToolTip = 'Specifies the value of the Expert Allowance field.', Comment = '%';
                }
                field(Accomodation; Rec.Accomodation)
                {
                    ToolTip = 'Specifies the value of the Accomodation field.', Comment = '%';
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                    ToolTip = 'Specifies the value of the Tuition Fee field.', Comment = '%';
                }
                field("Mileage Allowance"; Rec."Mileage Allowance")
                {
                    ToolTip = 'Specifies the value of the Mileage Allowance field.', Comment = '%';
                }
                field("Quarter Per Diem"; Rec."Quarter Per Diem")
                {
                    ToolTip = 'Specifies the value of the Quarter Per Diem field.', Comment = '%';
                }
            }
        }
    }
}
