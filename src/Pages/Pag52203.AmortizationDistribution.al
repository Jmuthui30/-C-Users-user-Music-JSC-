page 52203 "Amortization Distribution"
{
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Amortization Distribution";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(DeptName; DeptName)
                {
                    ApplicationArea = All;
                    Caption = 'Dept Name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(BranchName; BranchName)
                {
                    ApplicationArea = All;
                    Caption = 'Branch Name';
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(SIName; SIName)
                {
                    ApplicationArea = All;
                    Caption = 'SI Name';
                }
                field("Distribution Share"; Rec."Distribution Share")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Addition; Rec.Addition)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        GLSetup.Get;
        if Dim.Get(GLSetup."Global Dimension 1 Code", Rec."Global Dimension 1 Code")then DeptName:=Dim.Name;
        if Dim.Get(GLSetup."Global Dimension 2 Code", Rec."Global Dimension 2 Code")then BranchName:=Dim.Name;
        if Dim.Get(GLSetup."Shortcut Dimension 3 Code", Rec."Global Dimension 3 Code")then SIName:=Dim.Name;
    end;
    var GLSetup: Record "General Ledger Setup";
    DeptName: Text;
    BranchName: Text;
    SIName: Text;
    Dim: Record "Dimension Value";
}
