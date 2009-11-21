using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
namespace D4D.ResourceManager
{
   
    public  class ResourceConfig:IXmlSerializable
    {

        public CultureType Culture = CultureType.ZHCN;
        public Dictionary<string, string> ResourceDatas = new Dictionary<string, string>();

        #region IXmlSerializable Members

        public System.Xml.Schema.XmlSchema GetSchema()
        {
            return null;
        }

        public void ReadXml(XmlReader reader)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(reader);

            if (xmlDoc != null)
            {
               string culturestr = xmlDoc.DocumentElement.GetAttribute("Culture");
               if (!string.IsNullOrEmpty(culturestr))
                   Culture = ResourceHelper.CultureTypeFromString(culturestr);

               XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("//root/data");
               if (nodes != null && nodes.Count > 0)
               {
                   XmlElement nameElm;
                   XmlElement valueElm;
                   foreach (XmlElement elm in nodes)
                   {
                         nameElm = elm.SelectSingleNode("name") as XmlElement;
                         if (nameElm != null)
                         {
                             valueElm = elm.SelectSingleNode("value") as XmlElement;
                             if (valueElm != null)
                             {
                                 if (!ResourceDatas.ContainsKey(nameElm.InnerText))
                                 {
                                     ResourceDatas.Add(nameElm.InnerText, valueElm.InnerText);
                                 }
                             }
                         }
                   }
               }
            }
        }

        public void WriteXml(XmlWriter writer)
        {
            throw new NotImplementedException();
        }

        #endregion
    }

    
    
}
