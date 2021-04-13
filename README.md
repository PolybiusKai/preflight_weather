## Preflight Weather CLI 
Welcome to the Preflight Weather CLI! This CLI will give you access to a pilots preflight weather METARs readings. You can access this by using an Airports ICAO code (more on that below). The main reading is in the traditional METARs reading and can be broken down for easier reading. /// 
 
Once the program has started you will be prompted to enter your name followed by a greeting and a list of menu items. These menu items will be how you can access the different types of data ie METARs data, Station data and a list of Airports. If you at any time forget your way, you can always type 'help' to bring the menu back. 
 
```
>> help
              [#]  To see METARs Weather Data   - 'metar'.
              [#]  To see Station Data          - 'station'.
              [#]  To see a List of Airports    - 'list'.
              [#]  For Help Menu                - 'help'.
              [#]  To Exit The App              - 'exit'.
```
 
The METARs data will show you a string of weather information that's usually in a format that pilots will understand ie - METARs => KLAS 130356Z 04003KT 10SM FEW250 26/M11 A2968 RMK AO2 SLP028 T02611106. Once this displays you will be asked if you would like it broken down to a simplified format. 
 
```
    |    Station: KLAS                
    |    Time: 2021-04-13T03:56:00Z                      
    |    Wind Direction: 040                                
    |    Wind Speed: 03kt      
    |    Visibility: 10sm
    |    Weather: Clear
    |    Sky Conditions:  ["FEW250"]                                                              
    |    Temp/Dew Point: 26°C/-11                                                 
    |    Altimeter: 29.68                                                               
    |    Remarks: RMK AO2 SLP028 T02611106 
```
 
The Stations data will show you any information about a selected Airport by using its specified ICAP Code. 
```
::Under Construction::
 
```
 
The list of airports will display the name of the Airport along with its ICAO code and city. 
```
::Under Construction::
 
```
 
## In order to use this App.
Please get an API Key from AVWX at https://avwx.rest/ and create a new .env file with the following key:
```
AVWX_KEY=[YOUR_KEY_HERE]
```
 
## METAR
METAR - METeorological Aerodrome Reports (METARs)
 
METAR is a format for reporting weather information. A METAR weather report is predominantly used by aircraft pilots, and by meteorologists, who use aggregated METAR information to assist in weather forecasting. Raw METAR is the most common format in the world for the transmission of observational weather data. It is highly standardized through the International Civil Aviation Organization, which allows it to be understood throughout most of the world.
 - https://en.wikipedia.org/wiki/METAR
 
 
## ICAO AIRPORT KEYS
To see the METARs data you will have to enter the four letter Airport code called and ICAO (International Civil Aviation Organization) displayed below. Select one of the following to see its corresponding data. 
```
KATL = Atlanta, Georgia
ZBAA = Beijing, China
KLAX = Las Angeles, California - Las Angeles International
KORD = Chicago, Illinois - O'Hare International
KLAS = Las Vegas, Nevada - McCarran International
KDFW = Dallas-Fort Worth, Texas - For Worth International
KDEN = Denver, Colorado - Denver International
KJFK = Queens, New York, New York - John F. Kennedy International
KSFO = San Meteo County, California - San Fransisco International
KMCO = Orlando, Floida - Orlando International
KEWR = Newark, New Jersey - Newark Liverty International
KPHX = Phoenix, Arizona - Phoenix Sky Harbor Internatinoal
```

