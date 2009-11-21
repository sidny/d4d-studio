using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.ResourceManager
{

    public enum CultureType
    {
        Default = 0,
        DADK = 1,
        DEAT = 2,
        DECH = 3,
        DEDE = 4,
        ESES = 5,
        ESLA = 6,
        ESMX = 7,
        ESUS = 8,
        FIFI = 9,
        FRCA = 10,
        FRCH = 11,
        FRFR = 12,
        ITCH = 13,
        ITIT = 14,
        JAJP = 15,
        NBNO = 16,
        NLNL = 17,
        SVSE = 18,
        ZHCN = 19,
        ENAU = 20,
        ENCA = 21,
        ENGB = 22,
        ENIE = 23,
        ENIN = 24,
        ENNZ = 25,
        KOKR = 26,
        PTBR = 27,
        SESV = 28,
        ENKR = 29,
        FRBE = 30,
        NLBE = 31,
        PLPL = 32,
        PTPT = 33,
        RURU = 34,
        TUTR = 35,
        DKDK = 36,
        NONO = 37,
        ENUS = 38,
        DKDA = 39,
        TRTR = 40,
        Unknown = 50
    }

    public class ResourceHelper
    {

        public static string CultureTypeToString(CultureType type)
        {
            switch (type)
            {
                case CultureType.Default:
                    return "default";
                case CultureType.DADK:
                    return "da-DK";
                case CultureType.DEAT:
                    return "de-AT";
                case CultureType.DECH:
                    return "de-CH";
                case CultureType.DEDE:
                    return "de-DE";
                case CultureType.ESES:
                    return "es-ES";
                case CultureType.ESLA:
                    return "es-LA";
                case CultureType.ESMX:
                    return "es-MX";
                case CultureType.ESUS:
                    return "es-US";
                case CultureType.FIFI:
                    return "fi-FI";
                case CultureType.FRCA:
                    return "fr-CA";
                case CultureType.FRCH:
                    return "fr-CH";
                case CultureType.FRFR:
                    return "fr-FR";
                case CultureType.ITCH:
                    return "it-CH";
                case CultureType.ITIT:
                    return "it-IT";
                case CultureType.JAJP:
                    return "ja-JP";
                case CultureType.NBNO:
                    return "nb-NO";
                case CultureType.NLNL:
                    return "nl-NL";
                case CultureType.SVSE:
                    return "sv-SE";
                case CultureType.ZHCN:
                    return "zh-CN";
                case CultureType.ENAU:
                    return "en-AU";
                case CultureType.ENCA:
                    return "en-CA";
                case CultureType.ENGB:
                    return "en-GB";
                case CultureType.ENIE:
                    return "en-IE";
                case CultureType.ENIN:
                    return "en-IN";
                case CultureType.ENNZ:
                    return "en-NZ";
                case CultureType.KOKR:
                    return "ko-KR";
                case CultureType.PTBR:
                    return "pt-BR";
                case CultureType.SESV:
                    return "se-SV";
                case CultureType.ENKR:
                    return "en-KR";
                case CultureType.FRBE:
                    return "fr-BE";
                case CultureType.NLBE:
                    return "nl-BE";
                case CultureType.PLPL:
                    return "pl-PL";
                case CultureType.PTPT:
                    return "pt-PT";
                case CultureType.RURU:
                    return "ru-RU";
                case CultureType.TUTR:
                    return "tu-TR";
                case CultureType.DKDK:
                    return "dk-DK";
                case CultureType.NONO:
                    return "no-NO";
                case CultureType.ENUS:
                    return "en-US";
                case CultureType.DKDA:
                    return "dk-DA";
                case CultureType.TRTR:
                    return "tr-TR";
                default:
                    return string.Empty;
            }
        }


        public static CultureType CultureTypeFromString(string culture)
        {
            switch (culture.ToLower())
            {
                case "default":
                case "":
                    return CultureType.Default;
                case "da-dk":
                    return CultureType.DADK;
                case "de-at":
                    return CultureType.DEAT;
                case "de-ch":
                    return CultureType.DECH;
                case "de-de":
                    return CultureType.DEDE;
                case "es-es":
                    return CultureType.ESES;
                case "es-la":
                    return CultureType.ESLA;
                case "es-mx":
                    return CultureType.ESMX;
                case "es-us":
                    return CultureType.ESUS;
                case "fi-fi":
                    return CultureType.FIFI;
                case "fr-ca":
                    return CultureType.FRCA;
                case "fr-ch":
                    return CultureType.FRCH;
                case "fr-fr":
                    return CultureType.FRFR;
                case "it-ch":
                    return CultureType.ITCH;
                case "it-it":
                    return CultureType.ITIT;
                case "ja-jp":
                    return CultureType.JAJP;
                case "nb-no":
                    return CultureType.NBNO;
                case "nl-nl":
                    return CultureType.NLNL;
                case "sv-se":
                    return CultureType.SVSE;
                case "zh-cn":
                    return CultureType.ZHCN;
                case "en-au":
                    return CultureType.ENAU;
                case "en-ca":
                    return CultureType.ENCA;
                case "en-gb":
                    return CultureType.ENGB;
                case "en-ie":
                    return CultureType.ENIE;
                case "en-in":
                    return CultureType.ENIN;
                case "en-nz":
                    return CultureType.ENNZ;
                case "ko-kr":
                    return CultureType.KOKR;
                case "pt-br":
                    return CultureType.PTBR;
                case "se-sv":
                    return CultureType.SESV;
                case "en-kr":
                    return CultureType.ENKR;
                case "fr-be":
                    return CultureType.FRBE;
                case "nl-be":
                    return CultureType.NLBE;
                case "pl-pl":
                    return CultureType.PLPL;
                case "pt-pt":
                    return CultureType.PTPT;
                case "ru-ru":
                    return CultureType.RURU;
                case "tu-tr":
                    return CultureType.TUTR;
                case "dk-dk":
                    return CultureType.DKDK;
                case "no-no":
                    return CultureType.NONO;
                case "en-us":
                    return CultureType.ENUS;
                case "dk-da":
                    return CultureType.DKDA;
                case "tr-tr":
                    return CultureType.TRTR;
                default:
                    return CultureType.Unknown;
            }
        }



    }
}
