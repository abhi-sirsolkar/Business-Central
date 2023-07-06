page 73881 TestMail
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendEasiestEMail)
            {
                Caption = 'Send Easiest EMail';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                begin
                    EmailDemo_gCdu.SendEasiestEMail();
                end;
            }

            action(SendEmailWithAttachment)
            {
                Caption = 'Send Email With Attachment';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                begin
                    EmailDemo_gCdu.SendEmailWithAttachment();
                end;
            }

            action(SendEmailWithPreviewWindow)
            {
                Caption = 'Send Email With Preview Window';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                begin
                    EmailDemo_gCdu.SendEmailWithPreviewWindow();
                end;
            }

            action(SendEmailWithPreviewWindowHtmlFormatBody)
            {
                Caption = 'Send Email With Preview Window Html Format Body';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                begin
                    EmailDemo_gCdu.SendEmailWithPreviewWindowHtmlFormatBody();
                end;
            }

            action(SendEMail)
            {
                Caption = 'Send EMail';
                ApplicationArea = All;
                Image = Email;

                trigger OnAction()
                begin
                    EmailDemo_gCdu.SendEMail();
                end;
            }
        }
    }

    var
        EmailDemo_gCdu: Codeunit Email_Practice;
}