table 50003 "Document"
{
    // version THL
    Caption = 'Document';
    DrillDownPageID = "Document List";
    LookupPageID = "Document List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(5; "Document No."; Code[20])
        {
        }
        field(6; "Version No."; Integer)
        {
            Caption = 'Lease Contract Version No.';
        }
        field(10; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(25; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(26; Description; Text[120])
        {
            Caption = 'Description';
        }
        field(27; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(28; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(30; "Document Type Code"; Code[20])
        {
            Caption = 'Document Type Code';

            trigger OnValidate()
            begin
                if(xRec."Document Type Code" <> "Document Type Code") and (xRec."Document Type Code" <> '') and (xRec."Entry No." = "Entry No.")then begin
                    if not Confirm(StrSubstNo(Text901, FieldCaption("Document Type Code")), false)then begin
                        "Document Type Code":=xRec."Document Type Code";
                        exit;
                    end;
                    "Template Code":='';
                end;
            end;
        }
        field(31; "Template Code"; Code[20])
        {
            Caption = 'Template Code';

            trigger OnLookup()
            var
                Customer: Record Customer;
            begin
            end;
            trigger OnValidate()
            begin
                if(xRec."Template Code" <> "Template Code") and (xRec."Template Code" <> '') and (xRec."Entry No." = "Entry No.")then begin
                    if not Confirm(StrSubstNo(Text901, FieldCaption("Template Code")), false)then begin
                        "Template Code":=xRec."Template Code";
                        exit;
                    end;
                end;
            end;
        }
        field(41; Prepared; Boolean)
        {
            Caption = 'Prepared';

            trigger OnValidate()
            begin
                ValidateMarks;
                "Prepared mark By":=UserId;
                "Prepared mark DateTime":=CurrentDateTime;
                if Attachment.Get("Attachment No.")then begin
                    Attachment."Read Only":=Prepared;
                    Attachment.Modify;
                end;
            end;
        }
        field(42; "Prepared mark By"; Code[50])
        {
            Caption = 'Prepared mark By';
        }
        field(43; "Prepared mark DateTime"; DateTime)
        {
            Caption = 'Prepared mark DateTime';
        }
        field(45; Signed; Boolean)
        {
            Caption = 'Signed';

            trigger OnValidate()
            begin
                ValidateMarks;
                "Signed mark By":=UserId;
                "Signed mark DateTime":=CurrentDateTime;
            end;
        }
        field(46; "Signed mark By"; Code[50])
        {
            Caption = 'Signed mark By';
        }
        field(47; "Signed mark DateTime"; DateTime)
        {
            Caption = 'Signed mark DateTime';
        }
        field(50; Checked; Boolean)
        {
            Caption = 'Checked';

            trigger OnValidate()
            begin
                ValidateMarks;
                "Checked mark By":=UserId;
                "Checked mark DateTime":=CurrentDateTime;
            end;
        }
        field(51; "Checked mark By"; Code[50])
        {
            Caption = 'Checked mark By';
        }
        field(52; "Checked mark DateTime"; DateTime)
        {
            Caption = 'Checked mark DateTime';
        }
        field(100; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
            TableRelation = Attachment;
        }
        field(201; "Cross-ref to Document"; Integer)
        {
            Caption = 'Cross-ref to Document';
            TableRelation = Document WHERE("Customer No."=FIELD("Customer No."), "Document Type Code"=FIELD("Document Type Code"), "Table ID"=FIELD("Table ID"));
        }
        field(270; "Document Currency"; Code[10])
        {
            Caption = 'Document Currency';
            TableRelation = Currency;
        }
        field(735; "Checked by Lawyer"; Boolean)
        {
            Caption = 'Checked by Lawyer';

            trigger OnValidate()
            var
                locUserSetup: Record "User Setup";
            begin
                if not locUserSetup.Get(UserId)then locUserSetup.Init;
                //locUserSetup.TESTFIELD(Lawyer,TRUE);
                "Checked by Lawyer mark By":=UserId;
                "Checked by Lawyer mark Date":=CurrentDateTime;
            end;
        }
        field(740; "Checked by Lawyer mark By"; Code[50])
        {
            Caption = 'Checked by Lawyer mark By';
        }
        field(745; "Checked by Lawyer mark Date"; DateTime)
        {
            Caption = 'Checked by Lawyer mark Date';
        }
        field(746; "File Extension"; Text[250])
        {
            CalcFormula = Lookup(Attachment."File Extension" WHERE("No."=FIELD("Attachment No.")));
            FieldClass = FlowField;
        }
        field(747; "Ven. Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Mem Articles Of Assoc,CO7 Part. Of Directors,Tax Clearance Cert,Cert Of Incorporation,VAT Registration Cert';
            OptionMembers = , "Mem Articles Of Assoc", "CO7 Part. Of Directors", "Tax Clearance Cert", "Cert Of Incorporation", "VAT Registration Cert";
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.")
        {
        }
        key(Key3; "Attachment No.")
        {
        }
        key(Key4; "Table ID", "Customer No.")
        {
        }
        key(Key5; "Table ID", "Document No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        RestrictChanges;
    /*VOKOTH
        if "Attachment No." <> 0 then
            if Attachment.Get("Attachment No.") then
                if Attachment.RemoveAttachment(false) then;
                */
    end;
    trigger OnInsert()
    begin
        if "Entry No." = 0 then begin
            Document2.Reset;
            if Document2.FindLast then "Entry No.":=Document2."Entry No." + 1
            else
                "Entry No.":=1;
        end;
    end;
    trigger OnModify()
    begin
        RestrictChanges;
    end;
    trigger OnRename()
    begin
        RestrictChanges;
    end;
    var Text901: Label 'Change %1 ?';
    Text001: Label 'Replace existing attachment?';
    Text002: Label 'You have canceled the import process.';
    Text905: Label 'No document sets in this context';
    Document2: Record Document;
    Attachment: Record Attachment;
    Text907: Label 'Can not insert standard document set when contract documents already exists';
    procedure OpenAttachment()
    var
        Attachment: Record Attachment;
    begin
        if "Attachment No." = 0 then exit;
        Attachment.Get("Attachment No.");
    // VOKOTHAttachment.OpenAttachment(' ' + Description, false, '');
    end;
    procedure ImportAttachment(DocumentInstream: InStream; FileName: Text)
    var
        Attachment: Record Attachment;
        TempAttachment: Record Attachment temporary;
        // FileName: Text;
        FileMgt: Codeunit "File Management";
        OStream: OutStream;
    begin
        RestrictChanges;
        if "Attachment No." <> 0 then begin
            if Attachment.Get("Attachment No.")then Attachment.TestField("Read Only", false);
            if not Confirm(Text001, false)then exit;
            RemoveAttachment(false);
        end;
        Clear(TempAttachment);
    /*VOKOTH
        if TempAttachment.ImportAttachmentFromClientFile('', true, false) then begin
            Attachment.Insert(true);
            Attachment."Attachment File" := TempAttachment."Attachment File";
            Attachment."File Extension" := TempAttachment."File Extension";
            Attachment.Modify;
            "Attachment No." := Attachment."No.";
            Modify;
        end else
            Error(Text002);
            */
    end;
    procedure ExportAttachment()
    var
        Attachment: Record Attachment;
        FileName: Text[250];
    begin
    /*VOKOTH
        if Attachment.Get("Attachment No.") then
            Attachment.ExportAttachmentToClientFile(FileName);
            */
    end;
    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record Attachment;
    begin
        RestrictChanges;
    /*VOKOTH
        if Attachment.Get("Attachment No.") then
            if Attachment.RemoveAttachment(Prompt) then begin
                "Attachment No." := 0;
                Modify;
            end;
            */
    end;
    procedure RestrictChanges()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId)then Clear(UserSetup);
    end;
    procedure ValidateMarks()
    begin
        if Checked then begin
            TestField(Prepared, true);
            TestField(Signed, true);
        end;
        if Signed then TestField(Prepared, true);
        if Prepared then begin
            TestField("Document Date");
            TestField(Description);
        end;
        RestrictChanges;
    end;
    procedure InsertDefaultDocumentsContract(ContractNo: Code[20]; VersionNo: Integer)
    var
        Customer: Record Customer;
    begin
    /*THLIF ContractNo = '' THEN
          EXIT;
        
        IF NOT Contr.GET(ContractNo, VersionNo) THEN
          CLEAR(Contr);
        IF NOT Customer.GET(Contr."Customer No.") THEN
          CLEAR(Customer);
        
        
        DocSet.RESET;
        DocSet.SETFILTER("Valid From",'%1|..%2',0D,WORKDATE);
        DocSet.SETFILTER("Valid Until",'%1|%2..',0D,WORKDATE);
        
        IF NOT DocSet.FINDFIRST THEN
          ERROR(Text905);
        
        IF DocSet.COUNT>1 THEN
          IF PAGE.RUNMODAL(0,DocSet) <> ACTION::LookupOK THEN
            EXIT;
        
        InsertDefaultDocFromContact(ContractNo, VersionNo); // always first transfer links to clients documents
        
        DocSetLine.RESET;
        DocSetLine.SETCURRENTKEY("Line No. for sorting");
        DocSetLine.SETRANGE("Set ID",DocSet."Set ID");
        DocSetLine.SETFILTER("Valid From",'%1|..%2',0D,WORKDATE);
        DocSetLine.SETFILTER("Valid Until",'%1|%2..',0D,WORKDATE);
        
        IF DocSetLine.FINDFIRST THEN REPEAT
          // search if such document exists
          ContractDoc.RESET;
          ContractDoc.SETCURRENTKEY("Table ID", "Lease Contract No.");
          ContractDoc.SETRANGE("Table ID", DATABASE::"Lease Contract Header");
          ContractDoc.SETRANGE("Lease Contract No.", ContractNo);
          //ContractDoc.SETRANGE("Lease Contract Version No.", VersionNo);
          ContractDoc.SETRANGE("Document Type Code",DocSetLine."Document Type Code");
          ContractDoc.SETRANGE("Template Code",DocSetLine."Template Code");
          IF NOT ContractDoc.FINDFIRST THEN BEGIN
            DocNew.INIT;
            DocNew."Entry No.":=0;
            DocNew.INSERT(TRUE);
            DocNew."Customer No.":=Contr."Customer No.";
            DocNew."Lease Contract No.":= "Lease Contract No.";
            DocNew."Lease Contract Version No." := VersionNo;
            DocNew."Table ID" := DATABASE::"Lease Contract Header";
            DocNew."Document Date":=WORKDATE;
            DocNew."Document Type Code":=DocSetLine."Document Type Code";
            DocNew.VALIDATE("Template Code",DocSetLine."Template Code"); // transfer attachment
            DocNew.MODIFY;
          END;
        UNTIL DocSetLine.NEXT=0;
        */
    end;
    procedure TransferAttachmentFromTemplate(): Boolean var
        TemplateAttachment: Record Attachment;
        DocAttachment: Record Attachment;
    begin
    /*THLIF NOT Template.GET("Document Type Code","Template Code")
          THEN EXIT(FALSE);
        
        IF NOT TemplateAttachment.GET(Template."Attachment No.")
          THEN EXIT(FALSE);
        
        IF "Attachment No."<>0   // do not overwrite existing attachment
          THEN EXIT(FALSE);
        
        TemplateAttachment.CALCFIELDS(Attachment);
        DocAttachment:=TemplateAttachment;
        DocAttachment."No.":=0;
        DocAttachment.INSERT(TRUE);
        
        "Attachment No.":=DocAttachment."No.";
        
        EXIT(TRUE);
        */
    end;
    procedure TransferAttachmentFromDoc(var FromDocument: Record Document)
    var
        FromAttachment: Record Attachment;
        NewAttachment: Record Attachment;
    begin
        if FromDocument."Attachment No." = 0 then exit;
        if not FromAttachment.Get(FromDocument."Attachment No.")then exit;
        NewAttachment:=FromAttachment;
        NewAttachment."No.":=0;
        NewAttachment.Insert(true);
        "Attachment No.":=NewAttachment."No.";
    end;
    procedure InsertDefaultDocumentsContact(ContactNo: Code[20])
    var
        DocNew: Record Document;
        Document: Record Document;
    begin
    /*THLIF ContactNo = '' THEN
          EXIT;
        
        DocNew.RESET;
        DocNew.SETRANGE("Customer No.",ContactNo);
        DocNew.SETRANGE("Table ID", DATABASE::Customer);
        IF DocNew.FINDFIRST THEN
          ERROR(Text907);
        
        IF NOT Customer.GET(ContactNo) THEN
          CLEAR(Customer);
        
        DocSet.RESET;
        DocSet.SETFILTER("Valid From",'%1|..%2',0D,WORKDATE);
        DocSet.SETFILTER("Valid Until",'%1|%2..',0D,WORKDATE);
        
        IF NOT DocSet.FINDFIRST THEN
          ERROR(Text905);
        
        IF DocSet.COUNT > 1 THEN
          IF PAGE.RUNMODAL(0,DocSet) <> ACTION::LookupOK THEN
            EXIT;
        
        DocSetLine.RESET;
        DocSetLine.SETCURRENTKEY("Line No. for sorting");
        DocSetLine.SETRANGE("Set ID",DocSet."Set ID");
        DocSetLine.SETFILTER("Valid From",'%1|..%2',0D,WORKDATE);
        DocSetLine.SETFILTER("Valid Until",'%1|%2..',0D,WORKDATE);
        IF DocSetLine.FINDSET THEN
        REPEAT
          DocNew.INIT;
          DocNew."Entry No." := 0;
          DocNew.INSERT(TRUE);
          DocNew."Customer No.":= Customer."No.";
          DocNew."Table ID" := DATABASE::Customer;
          DocNew."Document Date" := WORKDATE;
          DocNew."Document Type Code" := DocSetLine."Document Type Code";
          DocNew.VALIDATE("Template Code",DocSetLine."Template Code");
          DocNew.MODIFY;
        UNTIL DocSetLine.NEXT=0;
        */
    end;
    procedure InsertDefaultDocFromContact(ContractNo: Code[20]; VersionNo: Integer)
    var
        FromDoc: Record Document;
        ToDoc: Record Document;
        Contact: Record Contact;
    begin
    /*THLIF ContractNo = '' THEN
          EXIT;
        
        Contr.GET(ContractNo, VersionNo);
        
        FromDoc.RESET;
        FromDoc.SETCURRENTKEY("Table ID","Customer No.");
        FromDoc.SETRANGE("Table ID", DATABASE::Customer);
        FromDoc.SETRANGE("Customer No.",Contr."Customer No.");
        IF FromDoc.FINDSET THEN
        REPEAT
          ToDoc.RESET;
          ToDoc.SETCURRENTKEY("Table ID", "Lease Contract No.");
        
          ToDoc.SETRANGE("Table ID", DATABASE::"Lease Contract Header");
          //ToDoc.SETRANGE(ToDoc."Lease Contract Version No.", VersionNo);
        
          ToDoc.SETRANGE("Lease Contract No.",ContractNo);
          ToDoc.SETRANGE("Document Type Code",FromDoc."Document Type Code");
          ToDoc.SETRANGE("Template Code",FromDoc."Template Code");
          IF ToDoc.FINDFIRST THEN BEGIN
            ToDoc."Cross-ref to Document":=FromDoc."Entry No.";
            ToDoc.MODIFY;
          END ELSE BEGIN
            ToDoc.RESET;
            ToDoc.INIT;
            ToDoc."Entry No.":=0;
            ToDoc.INSERT(TRUE);
            ToDoc."Customer No.":= Contr."Customer No.";
            ToDoc."Lease Contract No." := ContractNo;
            ToDoc."Table ID" := DATABASE::"Lease Contract Header";
            ToDoc."Lease Contract Version No." := VersionNo;
            ToDoc.Description:=FromDoc.Description;
            ToDoc."Document Date":=FromDoc."Document Date";
            ToDoc."Document Type Code":= FromDoc."Document Type Code";
            ToDoc."Template Code":=FromDoc."Template Code"; // don't transfer attachment
            ToDoc.Prepared:=FromDoc.Prepared;
            ToDoc."Prepared mark By":=FromDoc."Prepared mark By";
            ToDoc."Prepared mark DateTime":=FromDoc."Prepared mark DateTime";
            ToDoc.Signed:=FromDoc.Signed;
            ToDoc."Signed mark By":= FromDoc."Signed mark By";
            ToDoc."Signed mark DateTime":= FromDoc."Signed mark DateTime";
            ToDoc."Cross-ref to Document" := FromDoc."Entry No.";
            ToDoc.Comment := FromDoc.Comment;
            ToDoc.MODIFY;
           END;
        UNTIL FromDoc.NEXT=0;
        */
    end;
    procedure OpenAttachmentWithLink()
    var
        Attachment: Record Attachment;
        Document3: Record Document;
    begin
        if not Document3.Get("Cross-ref to Document")then exit;
        if Document3."Attachment No." = 0 then exit;
        Attachment.Get(Document3."Attachment No.");
    //VOKOTHAttachment.OpenAttachment(' ' + Document3.Description, false, '');
    end;
    procedure fnRelatedTableCaption(): Text[80]//VOKOTHvar
    //VOKOTH "Object": Record "Object";
    begin
    /*VOKOTH
        if Object.Get(Object.Type::Table, '', "Table ID") then begin
            Object.CalcFields(Caption);
            exit(CopyStr(Object.Caption, 1, 80));
        end else begin
            exit('');
        end;
        */
    end;
}
