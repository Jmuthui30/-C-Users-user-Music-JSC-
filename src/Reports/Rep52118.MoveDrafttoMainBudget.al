report 52118 "Move Draft to Main Budget"
{
    // version BUDGET
    Caption = 'Move Budget Distribution to the Draft Budget';
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Budget Name"; "G/L Budget Name")
        {
            RequestFilterFields = Name;

            trigger OnAfterGetRecord()
            begin
                EntryNo:=GetLastEntryNo;
                DraftBudget.Reset;
                DraftBudget.SetRange("Budget Name", "G/L Budget Name".Name);
                if DraftBudget.FindSet then begin
                    repeat EntryNo:=EntryNo + 1;
                        MainBudget.Init;
                        MainBudget.TransferFields(DraftBudget);
                        MainBudget."Entry No.":=EntryNo;
                        MainBudget.Insert;
                    until DraftBudget.Next = 0;
                end;
                DraftBudget.DeleteAll;
                "G/L Budget Name".Status:="G/L Budget Name".Status::Released;
                "G/L Budget Name".Modify;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var MainBudget: Record "G/L Budget Entry";
    DraftBudget: Record "Draft Budget Entry";
    EntryNo: Integer;
    local procedure GetLastEntryNo()LastEntryNo: Integer var
        MainBudget: Record "G/L Budget Entry";
    begin
        MainBudget.Reset;
        MainBudget.Ascending;
        if MainBudget.FindLast then LastEntryNo:=MainBudget."Entry No.";
    end;
}
