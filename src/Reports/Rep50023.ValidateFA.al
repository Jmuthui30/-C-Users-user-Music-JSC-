report 50023 "Validate FA"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Validate FA.rdlc';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            trigger OnAfterGetRecord()
            begin
                if "Fixed Asset"."FA Subclass Code" = 'FURN & FIT' then begin
                    if FADepBk.Get("Fixed Asset"."No.", 'DEFAULT')then begin
                        FADepBk.Validate("FA Posting Group", "Fixed Asset"."FA Subclass Code");
                        FADepBk.Validate("Declining-Balance %", 12.5);
                        FADepBk.Modify;
                    end;
                end
                else if "Fixed Asset"."FA Subclass Code" = 'OFFICE EQ' then begin
                        if FADepBk.Get("Fixed Asset"."No.", 'DEFAULT')then begin
                            FADepBk.Validate("FA Posting Group", "Fixed Asset"."FA Subclass Code");
                            FADepBk.Validate("Declining-Balance %", 12.5);
                            FADepBk.Modify;
                        end;
                    end
                    else if "Fixed Asset"."FA Subclass Code" = 'COMPUTER' then begin
                            if FADepBk.Get("Fixed Asset"."No.", 'DEFAULT')then begin
                                FADepBk.Validate("FA Posting Group", "Fixed Asset"."FA Subclass Code");
                                FADepBk.Validate("Declining-Balance %", 30);
                                FADepBk.Modify;
                            end;
                        end;
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
    trigger OnPostReport()
    begin
        Message('cOMPLETE');
    end;
    var FADepBk: Record "FA Depreciation Book";
}
