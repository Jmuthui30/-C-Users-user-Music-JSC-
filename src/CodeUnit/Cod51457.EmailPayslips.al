codeunit 51457 "Email Payslips"
{
    trigger OnRun()
    begin
        // Use the REPORT.RUNREQUESTPAGE function to run the request page to get report parameters
        XmlParameters:=REPORT.RUNREQUESTPAGE(51455);
        CurrentUser:=USERID;
        // Save the request page parameters to the database table
        WITH ReportParameters DO BEGIN
            // Cleanup
            IF GET(51455, CurrentUser)THEN DELETE;
            SETAUTOCALCFIELDS(Parameters);
            ReportId:=51455;
            UserId:=CurrentUser;
            Parameters.CREATEOUTSTREAM(OStream, TEXTENCODING::UTF8);
            OStream.WRITETEXT(XmlParameters);
            INSERT;
        END;
        //
        CLEAR(ReportParameters);
        XmlParameters:='';
        // Read the request page parameters from the database table
        WITH ReportParameters DO BEGIN
            SETAUTOCALCFIELDS(Parameters);
            GET(51455, CurrentUser);
            Parameters.CREATEINSTREAM(IStream, TEXTENCODING::UTF8);
            IStream.READTEXT(XmlParameters);
            XmlDocument.ReadFrom(IStream, xmldoc);
            if xmldoc.GetRoot(PSlip)then NodeList:=Pslip.GetChildElements();
            foreach Node1 in NodeList do begin
                Element:=Node1.AsXmlElement();
                NodeListSec:=Element.GetChildElements();
                foreach Node2 in NodeListSec do begin
                    case Node2.AsXmlElement().Name of 'name': Message(Node2.AsXmlElement().InnerText);
                    end;
                end;
            end;
        END;
        //Generate blob from report
        //with ReportParameters do begin
        ReportParameters.SetAutoCalcFields(Parameters);
        ReportParameters.Get(51455, CurrentUser);
        ReportParameters.Parameters.CreateInStream(IStream);
        IStream.ReadText(XmlParameters);
        //end;
        Employee.Reset();
        Employee.SETRANGE("No.", Employee."No.");
        if Employee.FindFirst()then RecRef.GetTable(Employee);
        TempBlob.CreateOutStream(outStreamReport);
        if Report.SaveAs(51455, XmlParameters, ReportFormat::Pdf, outStreamReport)then begin
            TempBlob.CreateInStream(inStreamReport);
            txtB64:=cnv64.ToBase64(inStreamReport, true);
            Subject:='Payslip';
            Body+='Hello, ' + Employee."Full Name";
            Body+='<br><br>';
            Body+='Kindly ignore this mail is for test purpose';
            Body+='<br><br>';
            Body+=StrSubstNo('Kindly find the attached payslip from %1.', CompInfo.Name); //, Format("Pay Period Filter", 0, '<Month text>-<Year4>'));
            Body+='<br><br>';
            Body+='Thank you.';
            Body+='<br><br>';
            Body+='Yours Sincerely,';
            Body+='<br><br>';
            Body+='<b>Payroll Department<b>';
            Body+='<br>';
            Body+=CompInfo.Name;
            ClientEmail.Add('vincent.okoth@teknohub.systems');
            Mail.Create(ClientEmail, Subject, Body, true);
            Mail.AddAttachment('Payslip.pdf', 'application/pdf', txtB64);
            Email.Send(Mail);
        end;
    end;
    var Payroll: Codeunit "Client Payroll Calculator";
    ReportParameters: Record "Report Parameters";
    XmlParameters: Text;
    CurrentUser: Code[50];
    OStream: OutStream;
    EmailPeriod: Record "Client Payroll Period";
    Period: Date;
    IStream: InStream;
    TempBlob: Codeunit "Temp Blob";
    Employee: Record "Client Employee Master";
    RecRef: RecordRef;
    PeriodName: Text;
    Comp: Code[20];
    ClientEmail: List of[Text];
    Subject: Text;
    Body: Text;
    CompInfo: Record "Client Company Information";
    Mail: Codeunit "Email Message";
    Email: Codeunit Email;
    outStreamReport: OutStream;
    inStreamReport: InStream;
    txtB64: Text;
    cnv64: Codeunit "Base64 Convert";
    xmldoc: XmlDocument;
    PSlip: XmlElement;
    NodeList: XmlNodeList;
    Node1: XmlNode;
    NodeListSec: XmlNodeList;
    Node2: XmlNode;
    Element: XmlElement;
}
