codeunit 52111 "EftPost"
{
    trigger OnRun()
    begin
        efth.Reset;
        efth.SetRange("EFT Posted", false);
        efth.SetRange(Status, efth.Status::"Processed by Bank");
        efth.SetFilter("Date Generated", '>=%1', CreateDateTime(20200801D, 0T));
        efth.SetFilter("Process Module", '<>%1', efth."Process Module"::PVs);
        Message('%1;', efth.Count);
        if efth.FindFirst then begin
            repeat Message(efth.No);
                // if CheckIfEFTIsAlreadyPosted(efth) then//Not Yet Posted
                //     eftcard.AutoPost(efth.No)
                // else begin//Already Posted
                efth."EFT Posted":=true;
                efth.Modify;
            //end;
            until efth.Next = 0;
        end;
        efth.Reset;
        efth.SetRange("EFT Posted", false);
        efth.SetRange(Status, efth.Status::"Processed by Bank");
        efth.SetFilter("Date Generated", '>=%1', CreateDateTime(20200801D, 0T));
        efth.SetFilter("Process Module", '%1', efth."Process Module"::PVs);
        if efth.FindFirst then begin
            repeat Message(efth.No);
                //VOO
                // if CheckIfEFTIsAlreadyPosted(efth) then//Not Yet Posted
                //                                        //eftcard.AutoPost(efth.No)
                //     else begin//Already Posted
                efth."EFT Posted":=true;
                efth.Modify;
            // end;
            until efth.Next = 0;
        //VOO..END
        end;
        exit;
    //pin.CRMUpdateMove;
    //EXIT;
    /*

        GetAccountBalances;
        GetAccountBalancesAll;
        exit;
        GetAccountStatement('0004527849', 20190301D, Today);
        exit;
        Result := '/api/transaction/process?transactions=';
        ArraySize := 1;
        VarArray := VarArray.CreateInstance(GetDotNetType(poststring), ArraySize);
        VarArray.SetValue(body, 0);
        poststring := 'transactions=' + VarArray.ToString;// 'transa' + '&amount=' +' 5000' + '&reference=' + 'XY46501';

        //HttpContent1 :=   VarArray.GetType();

        JsonSetOrdersExportedSend('http://eft.armpension.com:8080', Result, 'POST', HttpContent1, HttpResponseMessage1);
        Result := HttpResponseMessage1.Content.ReadAsStringAsync.Result;
        //APIResult := JsonConvert.DeserializeObject(result,GETDOTNETTYPE(APIResult));
        Message(Result);
        */
    end;
    var // HttpContent1: DotNet HttpContent;
    // HttpResponseMessage1: DotNet HttpResponseMessage;
    Result: Text;
    APIResult: Text;
    poststring: Text;
    body: Label '[{''amount'':''5000'',''reference'':''XY46501'',''vendor_name'':''Internet Ventures'',''vendor_code'':''AB561'',''vendor_account_number'':''0987364838'',''vendor_bank_code'':''67hb64}]';
    // VarArray: DotNet Array;
    ArraySize: Integer;
    // myText: DotNet String;
    // Values: DotNet Array;
    // Seperator: DotNet String;
    i: Integer;
    // Values2Save: DotNet Array;
    // myText2Save: DotNet String;
    clientmsg: Codeunit "Client Messaging";
    efth: Record "EFT Header";
    eftcard: Page "EFT Payment Card";
    local procedure JsonSetOrdersExportedSend(BaseUrl: Text; Method: Text; RestMethod: Text)
    // var
    //     httpclient: DotNet HttpClient;
    //     uri: DotNet Uri;
    begin
    /*
        httpclient := httpclient.HttpClient();
        httpclient.BaseAddress := uri.Uri(BaseUrl);

        case RestMethod of
            'GET':
                HttpResponseMessage := httpclient.GetAsync(Method).Result;
            'POST':
                HttpResponseMessage := httpclient.PostAsync(Method, HttpContent).Result;
            'PUT':
                HttpResponseMessage := httpclient.PutAsync(Method, HttpContent).Result;
            'DELETE':
                HttpResponseMessage := httpclient.DeleteAsync(Method).Result;
        end;
        HttpResponseMessage.EnsureSuccessStatusCode(); // Throws an error when no success
        */
    end;
    local procedure GetAccountBalances()
    begin
        Result:='/api/account/balance?';
        poststring:='account_number=0004527849';
        //JsonSetOrdersExportedSend('http://eft.armpension.com:8080', Result + poststring, 'POST', HttpContent1, HttpResponseMessage1);
        //Result := HttpResponseMessage1.Content.ReadAsStringAsync.Result;
        Message(Result);
    end;
    local procedure GetAccountBalancesAll()
    var
        temp: Text;
        pos: Integer;
        workstring: Text;
    begin
    /*
        BankAccountBalance.DeleteAll;
        Result := '/api/account/balance/all?';
        poststring := 'account_number=0004527849';
        JsonSetOrdersExportedSend('http://eft.armpension.com:8080', Result + poststring, 'POST', HttpContent1, HttpResponseMessage1);
        Result := HttpResponseMessage1.Content.ReadAsStringAsync.Result;
        workstring := ConvertStr(Result, '[', ']');
        myText := Result;
        Seperator := '[';
        Values := myText.Split(Seperator.ToCharArray());

        Seperator := ']';
        myText := Values.GetValue(1);
        Values := myText.Split(Seperator.ToCharArray());


        Seperator := '{';
        myText := Values.GetValue(0);
        Values := myText.Split(Seperator.ToCharArray());
        for i := 1 to Values.Length - 1 do begin
            myText := Values.GetValue(i);

            clientmsg.ReplaceString(myText, '",', '|', myText);
            myText := DelChr(myText, '=', '"},');


            Seperator := '|';
            myText2Save := myText;
            myText2Save := ConvertStr(myText2Save, ':', ',');
            Values2Save := myText2Save.Split(Seperator.ToCharArray());


            BankAccountBalance.Init;
            with BankAccountBalance do begin
                "Old BW Code" := SelectStr(2, Values2Save.GetValue(0));
                Evaluate(Name, SelectStr(2, Values2Save.GetValue(1)));
                Evaluate(PIN, SelectStr(2, Values2Save.GetValue(2)));
                // "Returned Amount" :=SELECTSTR(2,Values2Save.GetValue(3));
                //    "Bank Sort Code":=USERID;
                //  "Bank Account No.":=CURRENTDATETIME;
                Insert(true);
            end;
        end;
        //MESSAGE(FORMAT(VarArray.GetUpperBound(0) ));
        Message('All Bank Account Balance Retrieved successfully');
        */
    end;
    procedure GetAccountStatement(AccountNo: Text; StartDate: Date; EndDate: Date)
    var
        temp: Text;
        pos: Integer;
        workstring: Text;
        bankStatement: Record "NEFT Return Reasons";
    begin
    /*Result :='/api/account/statement?';
        poststring := 'account_number='+ AccountNo ;
        poststring += '&start_date='+  FORMAT(StartDate ,0,9) ;
        poststring += '&end_date='+ FORMAT(EndDate,0,9) ;
        JsonSetOrdersExportedSend('http://eft.armpension.com:8080',Result +poststring ,'POST',HttpContent1 ,HttpResponseMessage1);
        Result   := HttpResponseMessage1.Content.ReadAsStringAsync.Result;
        MESSAGE (Result);
        workstring := CONVERTSTR(Result,'[',']');
        myText :=Result ;
        Seperator :='[';
        Values :=myText.Split (Seperator.ToCharArray ());
        
        Seperator :=']';
        myText :=Values.GetValue(1);
        Values :=myText.Split (Seperator.ToCharArray ());
        
        Seperator :='{';
        myText :=Values.GetValue(0);
        Values :=myText.Split (Seperator.ToCharArray ());
        FOR i := 1 TO Values.Length - 1 DO  BEGIN
          myText :=  Values.GetValue(i);
        
          clientmsg.ReplaceString(myText,'",','|',myText );
         myText := DELCHR (myText,'=','"},');
        
        
        Seperator :='|';
        myText2Save  :=myText ;
        MESSAGE (myText2Save);
        myText2Save :=CONVERTSTR(myText2Save ,':',',');
        Values2Save :=myText2Save.Split (Seperator.ToCharArray ());
        
        FOR i := 1 TO Values2Save.Length - 1 DO
         MESSAGE ( FORMAT(Values2Save.GetValue(i)));
         bankStatement.INIT;
          WITH bankStatement DO
            BEGIN
               Code :=ConvertText2Date (SELECTSTR(2,Values2Save.GetValue(0)));
               Description :=SELECTSTR(2,Values2Save.GetValue(6));
                val_date :=ConvertText2Date (SELECTSTR(2,Values2Save.GetValue(2)));
            IF SELECTSTR(2,Values2Save.GetValue(3)) <> 'null' THEN   EVALUATE (debit,SELECTSTR(2,Values2Save.GetValue(3)));
             IF SELECTSTR(2,Values2Save.GetValue(4))  <> 'null' THEN   EVALUATE (credit,SELECTSTR(2,Values2Save.GetValue(4)));
                 EVALUATE( balance,SELECTSTR(2,Values2Save.GetValue(5)));
                reference :=SELECTSTR(2,Values2Save.GetValue(1));
        
               INSERT (TRUE);
        END ;
        END;
        //MESSAGE(FORMAT(VarArray.GetUpperBound(0) ));
        MESSAGE ('All Bank Account Balance Retrieved successfully');
        */
    end;
    local procedure ConvertText2Date(TextDate: Text): Date var
        Year: Integer;
        Month: Integer;
        day: Integer;
    begin
        if TextDate = '' then exit(0D);
        if not Evaluate(Year, CopyStr(TextDate, 1, 4))then exit(0D);
        if(Year < 1) or (Year > 9999)then exit(0D);
        if not Evaluate(Month, CopyStr(TextDate, 5, 2))then exit(0D);
        if(Month < 1) or (Month > 12)then exit(0D);
        if not Evaluate(day, CopyStr(TextDate, 7, 2))then exit(0D);
        if(day < 1) or (day > Date2DMY(CalcDate('<+1M-1D>', DMY2Date(1, Month, Year)), 1))then exit(0D);
        exit(DMY2Date(day, Month, Year));
    end;
    procedure SendEFTPayment(EFTNo: Text): Text var
        // xml: DotNet XmlDocument;
        // xmlnodelist: DotNet XmlNodeList;
        // i: Integer;
        // xmlnode: DotNet XmlNode;
        result: Text;
        j: Integer;
    begin
    /*
                xml := xml.XmlDocument();
                // MESSAGE(PIN + '----' + CODIGO.NavFieldName);
                result := 'http://' + clientmsg.GetSiteAddress + '/attainnavintegrator/EFTServ.asmx/ProcessPay?pvheaderNo=' + EFTNo;
                Message(result);
                xml.Load(result);


                xmlnodelist := xml.SelectNodes('//*');
                if (xmlnodelist.ToString() <> '') then begin
                    j := xmlnodelist.Count;

                    //FOR i := 0 TO xmlnodelist.Count - 1 DO
                    //BEGIN
                    xmlnode := xmlnodelist.Item(0);
                    if xmlnode.HasChildNodes then
                        result := xmlnode.FirstChild.InnerText;
                    exit(result);
                end
                */
    end;
    local procedure CheckIfEFTIsAlreadyPosted(var EFTHeader: Record "EFT Header")PostDecision: Boolean var
        PVHeader: Record "PV Header";
        GLRegister: Record "G/L Register";
        ImprestHeader: Record "Imprest Header";
        GLEntry: Record "G/L Entry";
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        //PVs
        if EFTHeader."Process Module" = EFTHeader."Process Module"::PVs then begin
            PostDecision:=true;
            PVHeader.Reset;
            PVHeader.SetRange(EFT_No, EFTHeader.No);
            if PVHeader.FindFirst then begin
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Document No.", PVHeader."No.");
                GLEntry.SetRange(GLEntry.Reversed, false);
                GLEntry.SetRange("Posting Date", PVHeader.Date);
                if GLEntry.FindFirst then begin
                    PVHeader.Posted:=true;
                    PVHeader.Validate(Posted);
                    PVHeader.Modify;
                    PostDecision:=false;
                end
                else
                    PostDecision:=true;
            end;
        end
        //Staff Claim
        else if(EFTHeader."Process Module" = EFTHeader."Process Module"::"Staff Claim")then begin
                PostDecision:=true;
                ImprestHeader.Reset;
                ImprestHeader.SetRange("EFT No", EFTHeader.No);
                if ImprestHeader.FindFirst then begin
                    BankLedger.Reset;
                    BankLedger.SetCurrentKey(BankLedger."Document No.", BankLedger."Posting Date");
                    BankLedger.SetRange(BankLedger."Document No.", ImprestHeader."No.");
                    if BankLedger.FindFirst then begin
                        ImprestHeader."Claim Pay Mode":='EFT';
                        ImprestHeader."Claim Payment Tx No":=EFTHeader.No;
                        ImprestHeader."Claim Posted":=true;
                        ImprestHeader."Claim Posted By":=UserId;
                        ImprestHeader."Claim Posted Date":=Today;
                        ImprestHeader."Staff Claim":=true;
                        ImprestHeader.Status:=ImprestHeader.Status::Released;
                        ImprestHeader.Modify;
                        PostDecision:=false;
                    end
                    else
                        PostDecision:=true;
                end;
            end
            //Imprest
            else if(EFTHeader."Process Module" = EFTHeader."Process Module"::"Imprest")then begin
                    PostDecision:=true;
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange("EFT No", EFTHeader.No);
                    if ImprestHeader.FindFirst then begin
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."Document No.", ImprestHeader."No.");
                        GLEntry.SetRange(GLEntry.Reversed, false);
                        GLEntry.SetRange("Posting Date", ImprestHeader.Date);
                        if GLEntry.FindFirst then begin
                            ImprestHeader."Pay Mode":='EFT';
                            ImprestHeader."Payment Tx No.(Cheque No.)":=EFTHeader.No;
                            if ImprestHeader."Paying Bank Code" = '' then ImprestHeader."Paying Bank Code":='111001';
                            ImprestHeader.Validate("Request Posted", true);
                            ImprestHeader."Request Posted By":=UserId;
                            ImprestHeader."Request Posted Date":=Today;
                            ImprestHeader.Type:=ImprestHeader.Type::Surrender;
                            ImprestHeader.Modify;
                            PostDecision:=false;
                        end
                        else
                            PostDecision:=true;
                    end;
                end
                //Surrender
                else if(EFTHeader."Process Module" = EFTHeader."Process Module"::Surrender)then begin
                        PostDecision:=true;
                        ImprestHeader.Reset;
                        ImprestHeader.SetRange("EFT No", EFTHeader.No);
                        if ImprestHeader.FindFirst then begin
                            GLEntry.Reset;
                            GLEntry.SetRange(GLEntry."Document No.", ImprestHeader."No.");
                            GLEntry.SetRange(GLEntry.Reversed, false);
                            GLEntry.SetRange("Posting Date", Today);
                            if GLEntry.FindFirst then begin
                                ImprestHeader."Claim Pay Mode":='EFT';
                                ImprestHeader."Surrender Posted":=true;
                                ImprestHeader."Surrender Posted By":=UserId;
                                ImprestHeader."Surrender Posted Date":=Today;
                                ImprestHeader.Type:=ImprestHeader.Type::Surrender;
                                ImprestHeader.Status:=ImprestHeader.Status::Released;
                                ImprestHeader.Modify;
                                PostDecision:=false;
                            end
                            else
                                PostDecision:=true;
                        end;
                    end;
        exit(PostDecision);
    end;
}
