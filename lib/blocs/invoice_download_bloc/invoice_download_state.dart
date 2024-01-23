part of 'invoice_download_bloc.dart';

sealed class InvoiceDownloadState extends Equatable {
  const InvoiceDownloadState();
  
  @override
  List<Object> get props => [];
}

final class InvoiceDownloadInitial extends InvoiceDownloadState {}
