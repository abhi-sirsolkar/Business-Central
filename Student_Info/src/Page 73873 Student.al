page 73873 Student
{
    ApplicationArea = All;
    Caption = 'Students';
    PageType = List;
    SourceTable = Student;
    UsageCategory = Lists;
    CardPageId = "Student Card";
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                    ExtendedDatatype = PhoneNo;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                    ExtendedDatatype = EMail;
                }
            }
        }
    }
}