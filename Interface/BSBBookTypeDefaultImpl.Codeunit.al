codeunit 50113 "BSB Book Type Default Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit der Pferdekutsche');
    end;
}