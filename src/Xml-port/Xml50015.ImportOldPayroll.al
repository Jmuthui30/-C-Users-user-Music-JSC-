xmlport 50015 "Import Old Payroll"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("Payroll OB";
    "Payroll OB")
    {
    XmlName = 'Payroll';

    fieldattribute(Period;
    "Payroll OB"."Payroll Period")
    {
    }
    fieldattribute(Name;
    "Payroll OB"."Full Names")
    {
    }
    fieldattribute(Basic;
    "Payroll OB".Basic)
    {
    }
    fieldattribute(House;
    "Payroll OB".House)
    {
    }
    fieldattribute(Medical;
    "Payroll OB".Medical)
    {
    }
    fieldattribute(LaptopRei;
    "Payroll OB".LaptopRei)
    {
    }
    fieldattribute(Gross;
    "Payroll OB".Gross)
    {
    }
    fieldattribute(InsRel;
    "Payroll OB".Insurance)
    {
    }
    fieldattribute(TaxableIncome;
    "Payroll OB".Taxable)
    {
    }
    fieldattribute(PAYE;
    "Payroll OB".PAYE)
    {
    }
    fieldattribute(Pension;
    "Payroll OB".Pension)
    {
    }
    fieldattribute(SHIF;
    "Payroll OB".SHIF)
    {
    }
    fieldattribute(NSSF;
    "Payroll OB".NSSF)
    {
    }
    fieldattribute(helb;
    "Payroll OB".HELB)
    {
    }
    fieldattribute(mhasibu;
    "Payroll OB".Mhasibu)
    {
    }
    fieldattribute(laptopded;
    "Payroll OB".Laptopded)
    {
    }
    fieldattribute(spouse;
    "Payroll OB".Spousemed)
    {
    }
    fieldattribute(totalded;
    "Payroll OB".TotalDed)
    {
    }
    fieldattribute(net;
    "Payroll OB".Net)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        StrLength:=StrLen("Payroll OB"."Full Names");
        StrPosOne:=StrPos("Payroll OB"."Full Names", ' ');
        NewName:=CopyStr("Payroll OB"."Full Names", StrPosOne, StrLength);
        NewLength:=StrLen(NewName);
        StrPosTwo:=StrPos(NewName, ' ');
        MiddleName:=CopyStr(NewName, 1, StrPosTwo - 1);
        Emp.Reset;
        Emp.SetRange("First Name", CopyStr("Payroll OB"."Full Names", 1, StrPosOne - 1));
        //Emp.SETRANGE("Middle Name",MiddleName);
        if Emp.FindFirst then "Payroll OB"."Payroll No.":=Emp."No."
        /*ELSE BEGIN
                    Emp.RESET;
                    Emp.SETRANGE("First Name",COPYSTR("Payroll OB"."Full Names",1,StrPosOne-1));
                    Emp.SETRANGE("Last Name",MiddleName);
                    IF Emp.FINDFIRST THEN
                      "Payroll OB"."Payroll No." := Emp."No."*/
        else
        begin
            "Payroll OB"."Payroll No.":=Format(Counter);
        end;
        //END;
        Counter:=Counter + 1;
        if Inserted.Get("Payroll OB"."Payroll No.", "Payroll OB"."Payroll Period")then begin
            "Payroll OB"."Payroll No.":=Emp."No." + '-' + Format(Counter);
        end;
    end;
    }
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
    trigger OnPostXmlPort()
    begin
        Message('Complete');
    end;
    trigger OnPreXmlPort()
    begin
        Counter:=0;
    end;
    var Emp: Record Employee;
    StrPosOne: Integer;
    StrPosTwo: Integer;
    Inserted: Record "Payroll OB";
    StrLength: Integer;
    NewLength: Integer;
    NewName: Text;
    MiddleName: Text;
    Counter: Integer;
}
