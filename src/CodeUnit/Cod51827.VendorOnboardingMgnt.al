codeunit 51827 "Vendor Onboarding Mgnt"
{
    trigger OnRun()
    begin
    end;
    procedure CreateVendor(var VendorReg: Record "Vendor Reg. Request")
    begin
        If Confirm(StrSubstNo(Text001, VendorReg."No."), false) = true then begin
            Vend.Init();
            Vend.Name:=VendorReg."Company Name";
            Vend.Address:=VendorReg."Reg. Office Address";
            Vend."E-Mail":=VendorReg."Email Address";
            Vend."Phone No.":=VendorReg."Phone Number";
            Vend."Mobile Phone No.":=VendorReg."Phone Number";
            Vend."VAT Registration No.":=VendorReg."VAT Reg No";
            Vend."Vendor Application No.":=VendorReg."No.";
            //Comment due to discussion with Me and Henry
            //Get Vendor No.
            /*if PurchSetup."Vendor Nos." = '' then
                 Counter := 0;
             TagInt := '';
             CreatedDate := Today;

             Vend."Vendor DateFormat" := Format(CreatedDate, 0, '<Year,2>');
             Vend."Vendor NameValue" := CopyStr(Vend.Name, 1, 1);

             Vend.Reset();
             Vend.SetRange("Vendor NameValue", Vend."Vendor NameValue");
             Vend.SetFilter("Vendor DateFormat", Vend."Vendor DateFormat");
             if Vend.FindSet() then begin
                 Counter := Vend.Count;
                 Counter := Counter + 1;
                 if Counter < 10 then
                     TagInt := '00' + Format(Counter)
                 else
                     if ((Counter > 10) And (Counter < 100)) then
                         TagInt := '0' + Format(Counter)
                     else
                         TagInt := Format(Counter);
                 Vend."No." := Vend."Vendor DateFormat" + Vend."Vendor NameValue" + TagInt;
             end else begin
                 Vend."No." := Vend."Vendor DateFormat" + Vend."Vendor NameValue" + '001';
             end;*/
            //
            Vend.Insert(true);
            VendorReg."Vendor Created":=true;
            VendorReg."Vendor No":=Vend."No.";
            VendorReg.Modify(true);
            If Confirm(StrSubstNo(Text002, Vend."No."), false) = true then Page.Run(Page::"Vendor Card", Vend)
            else
            begin
                exit;
            end;
        end
        else
        begin
            exit;
        end;
    end;
    [EventSubscriber(ObjectType::Table, 23, 'OnAfterInsertEvent', '', false, false)]
    procedure InsertVendorEvaluation(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        VendorEvaluation: Record "Vendor Evaluation";
        LineNo: Integer;
    begin
        VendorEvaluation.Init();
        VendorEvaluation."Vendor No.":=Rec."No.";
        VendorEvaluation."Vendor Name":=Rec.Name;
        VendorEvaluation.Date:=today;
        VendorEvaluation."Created By":=UserId;
        VendorEvaluation."Created Date":=Today;
        VendorEvaluation."Created Time":=Time;
        VendorEvaluation.Insert(true);
    end;
    var Vend: Record Vendor;
    Text001: Label 'You are about to Create a new Vendor from %1 Do you wish to continue?';
    Text002: Label 'New Vendor %1 have been created, Do you wish to Open the Card?';
    VendorReg: Record "Vendor Reg. Request";
    PurchSetup: Record "Purchases & Payables Setup";
    CreatedDate: date;
    Counter: Integer;
    TagInt: Code[10];
}
