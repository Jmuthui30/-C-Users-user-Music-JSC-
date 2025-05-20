report 50014 "Create FA Records"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Create FA Records.rdlc';

    dataset
    {
        dataitem("FA Opening Balances"; "FA Opening Balances")
        {
            trigger OnAfterGetRecord()
            begin
                //CREATE FA
                //myText := PADSTR('',3 - STRLEN(FORMAT("FA Opening Balances"."No.")),'0') + FORMAT("FA Opening Balances"."No.");
                //MESSAGE(PADSTR('',7 - STRLEN(FORMAT("FA Opening Balances"."No.")),'0') + FORMAT("FA Opening Balances"."No."));
                FA.Init;
                FA."No.":='FA-' + PadStr('', 7 - StrLen(Format("FA Opening Balances"."No.")), '0') + Format("FA Opening Balances"."No.");
                if "FA Opening Balances"."Desc 2" <> '' then FA.Validate(Description, "FA Opening Balances".Description + '-' + "FA Opening Balances"."Desc 2")
                else
                    FA.Validate(Description, "FA Opening Balances".Description + '-' + "FA Opening Balances".Location);
                FA."FA Class Code":='TANGIBLE';
                FA."FA Subclass Code":="FA Opening Balances".Subclass;
                FA."Global Dimension 1 Code":='ADMIN';
                FA."Global Dimension 2 Code":="FA Opening Balances".Location;
                FA."FA Location Code":="FA Opening Balances".Location;
                FA.Insert;
                //
                "FA Opening Balances"."FA No.":=FA."No.";
                "FA Opening Balances".Modify;
                //
                //FA DEPRECIATION BOOK
                FADep.Init;
                FADep.Validate("FA No.", "FA Opening Balances"."FA No.");
                FADep.Validate("Depreciation Book Code", 'DEFAULT');
                FADep."Depreciation Method":=FADep."Depreciation Method"::"Declining-Balance 1";
                FADep.Validate("Depreciation Starting Date", DMY2Date(1, 1, 2017));
                if "FA Opening Balances".Subclass = 'COMPUTER' then FADep.Validate("Declining-Balance %", 25)
                else if "FA Opening Balances".Subclass = 'FURN & FIT' then FADep.Validate("Declining-Balance %", 12.5)
                    else if "FA Opening Balances".Subclass = 'OFFICE EQ' then FADep.Validate("Declining-Balance %", 12.5);
                FADep.Insert;
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
        Message('Complete');
    end;
    var FA: Record "Fixed Asset";
    FADep: Record "FA Depreciation Book";
}
