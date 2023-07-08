codeunit 73883 Email_Practice
{
    procedure SendEasiestEMail()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create('your.email@gmail.com', 'This is the subject', 'This is the body');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithAttachment()
    var
        ReportExample: Report "Customer - Top 10 List";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        Body: Text;
    begin
        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Customer - Top 10 List", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);


        Body := '<h3>Dear Team,<br/><br/>I am sharing a report of the hours I have worked this month.<br/><br/>You can see a breakdown of the number of days/hours that I have worked. In total, I have worked (number) or days/hours.<br/><br/>Please can you confirm the total amount I will be paid for this month?<br/><br/>Please confirm when you have received this email and advise me when you have submitted it to the accounts department.<br/><br/>As always, feel free to message me if you have any questions, queries, or concerns about my hours worked this month.<br/><br/><hr><br/>Best regards, <br/> Abhishek Sirsolkar <br/> Trainee - Technical<br/><img src="https://intech-systems.com/wp-content/uploads/2022/10/intech-digital-logo.png" height = "30" width = "80"/>';

        EmailMessage.Create('your.email@gmail.com', 'Sample Report', Body, true);
        EmailMessage.AddAttachment('Report.pdf', 'PDF', InStr);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithPreviewWindow()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        Body := '<h3>TO MESSRS: ' + Customer.Name + ' </h3> ATT : ACCOUNTING DEPARTMENT </br> </h3> <hr></br>Your current balance with us is:</br></br><strong>' + format(Customer.Balance) + '</strong></br></br><hr></br>Best regards,</br>Abhishek Sirsolkar</br>Trainee - Technical</br> <img src="https://intech-systems.com/wp-content/uploads/2022/10/intech-digital-logo.png" height = "75" width = "100"/>';
        EmailMessage.Create('your.email@gmail.com', 'This is the subject', Body, true);
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithPreviewWindowHtmlFormatBody()
    var
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        Customer.FindFirst();
        Customer.CalcFields(Balance);

        Body := '<h3>Dear Team,<br/><br/>I am sharing a report of the hours I have worked this month.<br/><br/>You can see a breakdown of the number of days/hours that I have worked. In total, I have worked (number) or days/hours.<br/><br/>Please can you confirm the total amount I will be paid for this month?<br/><br/>Please confirm when you have received this email and advise me when you have submitted it to the accounts department.<br/><br/>As always, feel free to message me if you have any questions, queries, or concerns about my hours worked this month.<br/><br/><hr><br/>Best regards, <br/> Abhishek Sirsolkar <br/> Trainee - Technical<br/><img src="https://intech-systems.com/wp-content/uploads/2022/10/intech-digital-logo.png" height = "30" width = "80"/>';

        EmailMessage.Create('your.email@gmail.com', 'This is the subject', Body, true);
        Email.OpenInEditorModally(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEMail()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Cancelled: Boolean;
        MailSent: Boolean;
        Selection: Integer;
        OptionsLbl: Label 'Send,Open Preview';
        ListTo: List of [Text];
    begin
        Selection := Dialog.StrMenu(OptionsLbl);
        ListTo.Add('your.email1@gmail.com');
        ListTo.Add('your.email2@gmail.com');
        ListTo.Add('your.email3@gmail.com');
        EmailMessage.Create(ListTo, 'This is the subject', 'This is the body', true);
        Cancelled := false;
        if Selection = 1 then
            MailSent := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        if Selection = 2 then begin

            MailSent := Email.OpenInEditorModally(
                EmailMessage, Enum::"Email Scenario"::Default) = Enum::"Email Action"::Sent;
            Cancelled := not MailSent;
        end;

        if (Selection <> 0) and not MailSent and not Cancelled then
            Error(GetLastErrorText());
    end;

    var
        Customer: Record Customer;
}
