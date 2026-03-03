page 73876 "Student Card"
{
    Caption = 'Student Card';
    PageType = Card;
    SourceTable = Student;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(DOB; Rec.DOB)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DOB field.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
            }
            group(StudentPicture)
            {
                Caption = 'Student Picture';
                field("Student Picture"; Rec."Student Picture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Picture field.', Comment = '%';
                    ShowCaption = false;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Delete")
            {
                Caption = 'Delete';
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."Student Picture".HasValue then begin
                        if Confirm(ConfirmDeletePicture) then begin
                            Clear(Rec."Student Picture");
                            CurrPage.SaveRecord();
                        end;
                    end;
                end;
            }
        }
    }

    var
        ConfirmDeletePicture: Label 'Do you want to Delete Student Picture ?';
}
