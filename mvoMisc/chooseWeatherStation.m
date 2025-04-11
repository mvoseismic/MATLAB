function weatherStation = chooseWeatherStation( datimData )

if datimData > datenum(2023, 2, 9) && datimData < datenum(2023,5,19)
    weatherStation = "HermWx";
elseif datimData > datenum(2021, 6, 16) && datimData < datenum(2022,4,18)
    weatherStation = "SGHWx";
elseif datimData > datenum( 2023,12,4)
    weatherStation = "SGHWx";
else
    weatherStation = "Geralds";
end