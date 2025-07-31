codeunit 50110 "BSB Book Type Empty Impl."
{
    procedure StartDeployBook()
    begin
        Message('Bitte einen Typ <> '' '' angeben um Bereitstellung durchzuführen');
    end;

    procedure StartDeliverBook()
    begin
        Message('Bitte einen Typ <> '' '' angeben um Auslieferung durchzuführen');
    end;
}