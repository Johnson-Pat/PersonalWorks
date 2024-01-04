report 50300 "D365DL Whse. - Shipment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Layouts/WhseShipment.rdlc';
    ApplicationArea = all;
    Caption = 'Warehouse Shipment';
    UsageCategory = Documents;
    WordMergeDataItem = "Warehouse Shipment Header";

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(HeaderNo_WhseShptHeader; "No.")
            {
            }
            column(BarcodeFont; BarcodeMgt.BarcodeFont())
            { }
            column(WhseDocNoBarcode; WhseDocNoBarcode)
            { }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(CompanyName; COMPANYPROPERTY.DisplayName())
                {
                }
                column(TodayFormatted; Today)
                {
                }
                column(AssUid__WhseShptHeader; "Warehouse Shipment Header"."Assigned User ID")
                {
                    IncludeCaption = true;
                }
                column(HrdLocCode_WhseShptHeader; "Warehouse Shipment Header"."Location Code")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_WhseShptHeader; "Warehouse Shipment Header"."No.")
                {
                    IncludeCaption = true;
                }
                column(Show1; not Location."Bin Mandatory")
                {
                }
                column(Show2; Location."Bin Mandatory")
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(WarehouseShipmentCaption; WarehouseShipmentCaptionLbl)
                {
                }
                column(ShipToAddressLbl; ShipToAddressLbl)
                {
                }
                column(ShipToAddress1; ShipToAddress[1])
                {
                }
                column(ShipToAddress2; ShipToAddress[2])
                {
                }
                column(ShipToAddress3; ShipToAddress[3])
                {
                }
                column(ShipToAddress4; ShipToAddress[4])
                {
                }
                column(ShipToAddress5; ShipToAddress[5])
                {
                }
                column(ShipToAddress6; ShipToAddress[6])
                {
                }
                column(ShipToAddress7; ShipToAddress[7])
                {
                }
                column(ShipToAddress8; ShipToAddress[8])
                {
                }
                column(HeaderNo1_TrailerTime; "Warehouse Shipment Header"."D365WH Trailer Available Time")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_CollectionTime; "Warehouse Shipment Header"."D365WH Collection Time")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_DueToShipDate; "Warehouse Shipment Header"."D365WH Due to Ship Date")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_ShippingAgent; "Warehouse Shipment Header"."Shipping Agent Code")
                {
                }
                column(ShippingAgentLbl; ShippingAgentLbl)
                {
                }
                column(HeaderNo1_ShippingAgentService; "Warehouse Shipment Header"."Shipping Agent Service Code")
                {
                }
                column(ServiceLbl; ServiceLbl)
                {
                }
                column(HeaderNo1_PlannedArrivalTime; "Warehouse Shipment Header"."D365WH Planned Arrival Time")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_ArrivalTime; "Warehouse Shipment Header"."D365WH Arrival Time")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_TrailerRef; "Warehouse Shipment Header"."D365WH Trailer Ref.")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_LoadRef; "Warehouse Shipment Header"."D365WH Load Ref.")
                {
                    IncludeCaption = true;
                }
                column(Header1_ExternalDocumentNo; "Warehouse Shipment Header"."External Document No.")
                {
                    IncludeCaption = true;
                }

                dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemLinkReference = "Warehouse Shipment Header";
                    DataItemTableView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Assemble to Order");
                    CalcFields = "D365MF Variant Description";

                    dataitem(LineComment; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        column(LineComment_Comment; Comment)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, FilterCommentLines("Warehouse Shipment Line"."Source Line No."));
                        end;

                        trigger OnAfterGetRecord()
                        begin
                            GetCommentLine(Number = 1);
                        end;
                    }

                    dataitem(SourceDocComment; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        column(SourceDocComment_Comment; Comment)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Warehouse Shipment Line"."Source Document" = PrevWhseShipmentLine."Source Document") and
                                ("Warehouse Shipment Line"."Source No." = PrevWhseShipmentLine."Source No.") then
                                CurrReport.Break();

                            SetRange(Number, 1, FilterCommentLines(0));
                        end;

                        trigger OnAfterGetRecord()
                        begin
                            GetCommentLine(Number = 1);
                        end;

                        trigger OnPostDataItem()
                        begin
                            PrevWhseShipmentLine := "Warehouse Shipment Line";
                        end;
                    }

                    column(ShelfNo_WhseShptLine; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemNo_WhseShptLine; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Desc_WhseShptLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(UomCode_WhseShptLine; "Unit of Measure Code")
                    {
                        IncludeCaption = true;
                    }
                    column(LocCode_WhseShptLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Qty_WhseShptLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(SourceNo_WhseShptLine; "Source No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SourceDoc_WhseShptLine; "Source Document")
                    {
                        IncludeCaption = true;
                    }
                    column(SourceLineNo_WhseShptLine; "Source Line No.")
                    {
                    }
                    column(ZoneCode_WhseShptLine; "Zone Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_WhseShptLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Variant_Code_WhseShptLine; "Variant Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Unit_of_Measure_Code; "Unit of Measure Code")
                    {
                    }
                    column(UofMLbl; UofMLbl)
                    {
                    }
                    column(Qty__per_Unit_of_Measure; "Qty. per Unit of Measure")
                    {
                    }
                    column(QtyPerUofMLbl; QtyPerUofMLbl)
                    {
                    }
                    column(Quantity; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(Qty__to_Ship; "Qty. to Ship")
                    {
                        IncludeCaption = true;
                    }
                    column(Over_Shpt_Allowce_Type; "D365OS Over-Shpt Allowce Type")
                    {
                    }
                    column(OverShipTypeLbl; OverShipTypeLbl)
                    {
                    }
                    column(Over_Shpt_Backfill_Item; format("D365OS Over-Shpt Backfill Item"))
                    {
                    }
                    column(OverShipBackfillItemLbl; OverShipBackfillItemLbl)
                    {
                    }
                    column(D365OS_Over_Shpt_Qty__Allowed; "D365OS Over-Shpt Qty. Allowed")
                    {
                    }
                    column(OverShipQtyAllowedLbl; OverShipQtyAllowedLbl)
                    {
                    }
                    column(D365DS_Item_Idt__Barcode_UofM; "D365DS Item Idt. Barcode UofM")
                    {
                    }
                    column(BarcodeUofMLbl; BarcodeUofMLbl)
                    {
                    }
                    column(D365DS_Qty__per_Barcode_UofM; "D365DS Qty. per Barcode UofM")
                    {
                    }
                    column(QtyPerLbl; QtyPerLbl)
                    {
                    }
                    column(D365DS_Quantity__Barcode_UofM_; "D365DS Quantity (Barcode UofM)")
                    {
                    }
                    column(QtyLbl; QtyLbl)
                    {
                    }
                    column(ItemVariant_PalletDescr; "D365MF Variant Description")
                    {
                    }
                    column(DescriptionLbl; DescriptionLbl)
                    {
                    }
                    column(SourceDocHdrCommentsLbl; SourceDocHdrCommentsLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        GetLocation("Location Code");
                        GetShipToAddress();
                    end;
                }
            }


            trigger OnAfterGetRecord()
            begin
                CalcFields("D365WH Due to Ship Date");
                GetLocation("Location Code");
                WhseDocNoBarcode := BarcodeMgt.EncodeToCode128("Warehouse Shipment Header"."No.");
            end;
        }
    }

    var
        PrevWhseShipmentLine: Record "Warehouse Shipment Line";
        SalesCommentLine: Record "Sales Comment Line";
        PurchCommentLine: Record "Purch. Comment Line";
        Location: Record Location;
        BarcodeMgt: Codeunit "D365DS Barcode Mgt.";
        CurrReportPageNoCaptionLbl: Label 'Page';
        WarehouseShipmentCaptionLbl: Label 'Warehouse Shipment:';
        UofMLbl: Label 'UofM';
        QtyPerUofMLbl: Label 'Qty. per UofM';
        ShipToAddressLbl: Label 'Ship-to Address';
        ShippingAgentLbl: Label 'Shipping Agent';
        ServiceLbl: Label 'Service';
        OverShipTypeLbl: Label 'Over-Ship Type';
        OverShipBackfillItemLbl: Label 'Over-Ship Backfill Item';
        OverShipQtyAllowedLbl: Label 'Over-Ship Qty. Allowed';
        BarcodeUofMLbl: Label 'Barcode - UofM:';
        QtyPerLbl: Label 'Qty Per:';
        QtyLbl: Label 'Qty.:';
        DescriptionLbl: Label 'Description:';
        SourceDocHdrCommentsLbl: Label 'Source Document Header Comments';
        WhseDocNoBarcode: Text;
        Comment: Text;
        ShipToAddress: array[8] of Text[100];


    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init()
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure FilterCommentLines(DocumentLineNo: Integer): Integer
    begin
        case "Warehouse Shipment Line"."Source Document" of
            "Warehouse Shipment Line"."Source Document"::"Sales Order":
                begin
                    SalesCommentLine.Reset();
                    SalesCommentLine.SetRange("Document Type", "Warehouse Shipment Line"."Source Subtype");
                    SalesCommentLine.SetRange("No.", "Warehouse Shipment Line"."Source No.");
                    SalesCommentLine.SetRange("Document Line No.", DocumentLineNo);
                    exit(SalesCommentLine.Count);
                end;
            "Warehouse Shipment Line"."Source Document"::"Purchase Return Order", "Warehouse Shipment Line"."Source Document"::"Purchase Order":
                begin
                    PurchCommentLine.Reset();
                    PurchCommentLine.SetRange("Document Type", "Warehouse Shipment Line"."Source Subtype");
                    PurchCommentLine.SetRange("No.", "Warehouse Shipment Line"."Source No.");
                    PurchCommentLine.SetRange("Document Line No.", DocumentLineNo);
                    exit(PurchCommentLine.Count);
                end;
        end;
    end;

    local procedure GetCommentLine(FirstLine: Boolean)
    begin
        case "Warehouse Shipment Line"."Source Document" of
            "Warehouse Shipment Line"."Source Document"::"Sales Order":
                begin
                    if FirstLine then
                        SalesCommentLine.FindSet()
                    else
                        SalesCommentLine.Next();
                    Comment := SalesCommentLine.Comment;
                end;
            "Warehouse Shipment Line"."Source Document"::"Purchase Return Order", "Warehouse Shipment Line"."Source Document"::"Purchase Order":
                begin
                    if FirstLine then
                        PurchCommentLine.FindSet()
                    else
                        PurchCommentLine.Next();
                    Comment := PurchCommentLine.Comment;
                end;
        end;
    end;

    local procedure GetShipToAddress()
    var
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        TransferHeader: Record "Transfer Header";
        FormatAddress: Codeunit "Format Address";
        BlankAddress: array[8] of Text[100];
    begin
        case "Warehouse Shipment Line"."Source Document" of
            "Warehouse Shipment Line"."Source Document"::"Sales Order":
                begin
                    SalesHeader.Get("Warehouse Shipment Line"."Source Subtype", "Warehouse Shipment Line"."Source No.");
                    FormatAddress.SalesHeaderShipTo(ShipToAddress, BlankAddress, SalesHeader);
                end;
            "Warehouse Shipment Line"."Source Document"::"Purchase Return Order", "Warehouse Shipment Line"."Source Document"::"Purchase Order":
                begin
                    PurchaseHeader.Get("Warehouse Shipment Line"."Source Subtype", "Warehouse Shipment Line"."Source No.");
                    FormatAddress.PurchHeaderShipTo(ShipToAddress, PurchaseHeader);
                end;
            "Warehouse Shipment Line"."Source Document"::"Outbound Transfer":
                begin
                    TransferHeader.Get("Warehouse Shipment Line"."Source No.");
                    FormatAddress.TransferHeaderTransferTo(ShipToAddress, TransferHeader);
                end;
        end;
    end;
}

