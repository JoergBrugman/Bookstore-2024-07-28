page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    CardPageId = "BSB Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(ISBN; Rec.ISBN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Author field.', Comment = '%';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Pages field.', Comment = '%';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(ClassicCode_Promoted; ClassicCode) { }
            actionref(ClassicCodeWithEvent_Promoted; ClassicCodeWithEvent) { }
            actionref(UsingInterface_Promoted; UsingInterface) { }
            actionref(UsingInterfaceWithEnum_Promoted; UsingInterfaceWithEnum) { }
        }
        area(Processing)
        {
            action(ClassicCode)
            {
                Caption = 'Classic Code';
                ApplicationArea = All;
                Image = CreateWorkflow;
                ToolTip = 'Executes the Classic Code action.';

                trigger OnAction()
                var
                    BSBBookTypeEmptyImpl: Codeunit "BSB Book Type Empty Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            begin
                                BSBBookTypeEmptyImpl.StartDeployBook();
                                BSBBookTypeEmptyImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                    end;
                end;
            }
            action(ClassicCodeWithEvent)
            {
                Caption = 'Classic Code with Event';
                ApplicationArea = All;
                Image = CreateWorkflow;
                ToolTip = 'Executes the Classic Code with Event action.';

                trigger OnAction()
                var
                    BSBBookTypeEmptyImpl: Codeunit "BSB Book Type Empty Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    IsHandled: Boolean;
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            begin
                                BSBBookTypeEmptyImpl.StartDeployBook();
                                BSBBookTypeEmptyImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                        else
                            OnExecuteBookTypeProcess(IsHandled);
                    end;
                end;
            }
            action(UsingInterface)
            {
                Caption = 'Using Interface';
                ApplicationArea = All;
                Image = CreateWorkflow;
                ToolTip = 'Executes the using Interface action.';

                trigger OnAction()
                var
                    BSBBookTypeEmptyImpl: Codeunit "BSB Book Type Empty Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            BSBBookTypeProcess := BSBBookTypeEmptyImpl;
                        "BSB Book Type"::Hardcover:
                            BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                    end;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
            action(UsingInterfaceWithEnum)
            {
                Caption = 'Using Interface with Enum';
                ApplicationArea = All;
                Image = CreateWorkflow;
                ToolTip = 'Executes the using Interface with Enum action.';

                trigger OnAction()
                var
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                begin
                    BSBBookTypeProcess := Rec.Type;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }

        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnExecuteBookTypeProcess(var IsHandled: Boolean)
    begin
    end;
}