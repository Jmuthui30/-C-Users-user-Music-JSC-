codeunit 51436 "Client Messaging"
{
    // version AES-PAS 1.0
    trigger OnRun()
    begin
    //GenerateFullBirthdayAlert;
    /*MESSAGE ('%1', IsValidEmail('poke.finance@poke.global'));
        MESSAGE ('%1', IsValidEmail('ezinne.oge@armpension.com'));
        MESSAGE ('%1', IsValidEmail('rah@armpension.com'));*/
    end;
    var ClientRec: Record Vendor;
    URL: Text[500];
    messageparam: Text[100];
    phoneparam: Text[100];
    position: Integer;
    url2: Text[1024];
    smsresp: Text;
    Email: Text;
    siteaddress: Label '192.168.0.31';
    cols: Integer;
    rows: Integer;
    messageText: Text;
    webAddress: Label 'crm.armpension.com';
    kycescalationemailacct: Label 'moronke.bamgbala@armpension.com';
    caseescalationemailacct: Label 'cxsupervisors@armpension.com';
    kycescalationemailacctcc: Label 'abisola.onigbogi@armpension.com';
    caseescalationemailacctcc: Label 'moronke.bamgbala@armpension.com';
    MyFile: File;
    Myoutstream: OutStream;
    NumberOfChars: Integer;
    edEmail: Label 'layi.afolabi@armpension.com';
    mdemail: Label 'wale.odutola@armpension.com';
    UserSetup: Record User;
    attachmentfolder: Label '\\s-hqp-dmgt01\UploadedDocs\';
    Text001: Label 'Default';
    counter: Integer;
    MovedCounter: Integer;
    tomovecounter: Integer;
    EmployerAttachmentFolder: Label '\\S-hqp-dmgt01\code\employer';
    procedure GetSiteAddress()response: Text var
        //SmsTable: Record "Birthday Msg";
        LastAutoID: BigInteger;
        txtInternetAddr: Text[250];
        txtInternetAddr2: Text[250];
        // ClientSetup: Record "Client & Fund Mgt. Setup";
        //SMSSetup: Record "SMS Setup";
        // DotNetVar: DotNet HttpContentHeaders;
        // HTTPWebRequest: DotNet HttpWebRequest;
        // HTTPWebResponse: DotNet HttpWebResponse;
        // DotNetString: Variant;
        // Xml: DotNet XmlDocument;
        // url1: Text;
        // SystemString: DotNet Uri;
        PhoneLength: Integer;
    //SMSEntry: Record "Birthday Msg";
    begin
        //MESSAGE(smsresp);
        exit(siteaddress)end;
    procedure ReplaceString(String: Text[1000]; FindWhat: Text[500]; ReplaceWith: Text[500]; var NewString: Text[1000])
    begin
        while StrPos(String, FindWhat) > 0 do String:=DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString:=String;
    //MESSAGE('tHE sTRING %',NewString);
    end;
    procedure ValidatorSpecialwithRegex(SearchString: Text[1000]; RegEx: Text[500]): Integer // var
    //     dnRegEx: DotNet Regex;
    //     dnMatch: DotNet Match;
    begin
    // dnMatch := dnRegEx.Match(SearchString, RegEx);
    // if dnMatch.Success then
    //     exit(dnMatch.Index + 1)
    // else
    //     exit(0);
    end;
    procedure GetMonthDate(realdate: Date)datemonth: Text begin
        //ClientRec
        datemonth:=Format(Date2DMY(realdate, 1)) + Format(Date2DMY(realdate, 2));
        datemonth:=PadStr('', 2 - StrLen(Format(Date2DMY(Today, 1))), '0') + Format(Date2DMY(realdate, 1));
        datemonth:=datemonth + PadStr('', 2 - StrLen(Format(Date2DMY(realdate, 2))), '0') + Format(Date2DMY(realdate, 2));
    end;
}
