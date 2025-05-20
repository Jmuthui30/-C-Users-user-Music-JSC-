report 50016 "Insert Payroll Values"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Insert Payroll Values.rdlc';

    dataset
    {
        dataitem("Payroll OB"; "Payroll OB")
        {
            RequestFilterFields = "Payroll Period";

            trigger OnAfterGetRecord()
            begin
                /*//BASIC
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Payment;
                Matrix.VALIDATE(Code,'BASIC');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Basic);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //HOUSE
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Payment;
                Matrix.VALIDATE(Code,'HOUSE');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".House);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //MEDICAL
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Payment;
                Matrix.VALIDATE(Code,'MEDICAL');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Medical);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //LAPTOP
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Payment;
                Matrix.VALIDATE(Code,'LAPTOP');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".LaptopRei);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //INSURANCE
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Payment;
                Matrix.VALIDATE(Code,'RELIEF');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Insurance);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                
                //PAYE
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'PAYE');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".PAYE);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //PENSION
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'PENSION');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Pension);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //SHIF
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'SHIF');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".SHIF);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //NSSF
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'NSSF');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".NSSF);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //HELB
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'HELB');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".HELB);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //MHASIBU
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'MHASIBU');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Mhasibu);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //LAPTOP
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'LAPTOP');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Laptopded);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                //SPOUSE
                Matrix.INIT;
                Matrix."Employee No" := "Payroll OB"."Payroll No.";
                Matrix.Type := Matrix.Type::Deduction;
                Matrix.VALIDATE(Code,'SPOUSEMED');
                Matrix.VALIDATE("Payroll Period","Payroll OB"."Payroll Period");
                Matrix.VALIDATE(Amount,"Payroll OB".Spousemed);
                IF "Payroll OB"."Payroll Period"< DMY2DATE(1,7,2017) THEN
                Matrix.Closed := TRUE
                ELSE
                Matrix."Next Period Entry" := TRUE;
                IF Matrix.Amount <> 0 THEN
                Matrix.INSERT;
                */
                //PAYE
                Matrix.Init;
                Matrix."Employee No":="Payroll OB"."Payroll No.";
                Matrix.Type:=Matrix.Type::Deduction;
                Matrix.Validate(Code, 'PAYE');
                Matrix.Validate("Payroll Period", "Payroll OB"."Payroll Period");
                Matrix.Validate(Amount, "Payroll OB".PAYE);
                if "Payroll OB"."Payroll Period" < DMY2Date(1, 1, 2017)then Matrix.Closed:=true
                else
                    Matrix."Next Period Entry":=true;
                if Matrix.Amount <> 0 then Matrix.Insert;
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
        Message('COMPLETE');
    end;
    var Matrix: Record "Payroll Matrix";
}
