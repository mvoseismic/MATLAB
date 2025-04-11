function vtStrings = get_string_subset( vtStringsIn, searchText )
%
% Extracts subset of strings read from spreadsheet
%
% R.C.Stewart, 2022-04-13

%vtStrings = repmat( vtStringsIn, 0, 0 );

% Only use wanted lines
idWanted1 = contains( string( vtStringsIn.What ), searchText );
idWanted2 = string( vtStringsIn.Id ) ~= "";
idWanted = idWanted1 & idWanted2;

vtStrings.Id = vtStringsIn.Id( idWanted );
vtStrings.What = vtStringsIn.What( idWanted );
vtStrings.Checked = vtStringsIn.Checked( idWanted );
vtStrings.EventFile = vtStringsIn.EventFile( idWanted );
vtStrings.Heliplot = vtStringsIn.Heliplot( idWanted );
vtStrings.Multiplot = vtStringsIn.Multiplot( idWanted );
vtStrings.SeisanFiles = vtStringsIn.SeisanFiles( idWanted );
vtStrings.Form = vtStringsIn.Form( idWanted );
vtStrings.Purity = vtStringsIn.Purity( idWanted );
vtStrings.RepeatingEvents = vtStringsIn.RepeatingEvents( idWanted );
vtStrings.DatimFirst = vtStringsIn.DatimFirst( idWanted );
vtStrings.DatimLast = vtStringsIn.DatimLast( idWanted );
vtStrings.Duration = vtStringsIn.Duration( idWanted );
vtStrings.NumSeisan = vtStringsIn.NumSeisan( idWanted );
vtStrings.NumLocated = vtStringsIn.NumLocated( idWanted );
vtStrings.NumTotal = vtStringsIn.NumTotal( idWanted );
vtStrings.MaxMl = vtStringsIn.MaxMl( idWanted );
vtStrings.StaFirst = vtStringsIn.StaFirst( idWanted );
vtStrings.StaSecond = vtStringsIn.StaSecond( idWanted );
vtStrings.StaPicked = vtStringsIn.StaPicked( idWanted );
vtStrings.MBBY = vtStringsIn.MBBY( idWanted );
vtStrings.MBFR = vtStringsIn.MBFR( idWanted );
vtStrings.MBGH = vtStringsIn.MBGH( idWanted );
vtStrings.MBHA = vtStringsIn.MBHA( idWanted );
vtStrings.MBLG = vtStringsIn.MBLG( idWanted );
vtStrings.MBLY = vtStringsIn.MBLY( idWanted );
vtStrings.MBRY = vtStringsIn.MBRY( idWanted );
vtStrings.MBWH = vtStringsIn.MBWH( idWanted );
vtStrings.MBWW = vtStringsIn.MBWW( idWanted );
vtStrings.MSCP = vtStringsIn.MSCP( idWanted );
vtStrings.MSMX = vtStringsIn.MSMX( idWanted );
vtStrings.MSS1 = vtStringsIn.MSS1( idWanted );
vtStrings.MSUH = vtStringsIn.MSUH( idWanted );
vtStrings.Comment = vtStringsIn.Comment( idWanted );


