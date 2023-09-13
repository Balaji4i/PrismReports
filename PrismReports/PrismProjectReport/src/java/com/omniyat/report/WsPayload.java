/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.omniyat.report;

/**
 *
 * @author gautham.r
 */
public class WsPayload {
       static String getProjectSummary(long p_bu_id,String p_status,String p_as_on_date) {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        String projectSummary =
"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v2=\"http://xmlns.oracle.com/oxp/service/v2\">\n" +
"   <soapenv:Header/>\n" +
"   <soapenv:Body>\n" +
"      <v2:runReport>\n" +
"         <v2:reportRequest>\n" +
"            <v2:parameterNameValues>\n" +
"               <v2:listOfParamNameValues>\n" +
"                  <!--Zero or more repetitions:-->\n" +
"                  <v2:item>\n" +
"                     <v2:name>p_bu_id</v2:name>\n" +
"                     <v2:values>\n" +
"                        <!--Zero or more repetitions:-->\n" +
"                        <v2:item>"+p_bu_id+"</v2:item>\n" +
"                     </v2:values>\n" +
"                  </v2:item>\n" +
"                  <v2:item>\n" +                
"                     <v2:name>p_status</v2:name>\n" +
"                     <v2:values>\n" +
"                        <!--Zero or more repetitions:-->\n" +
"                        <v2:item>"+p_status+"</v2:item>\n" +
"                     </v2:values>\n" +
"                  </v2:item>\n" +
"                  <v2:item>\n" +
"                     <v2:name>p_as_on_date</v2:name>\n" +
"                     <v2:values>\n" +
"                        <!--Zero or more repetitions:-->\n" +
"                        <v2:item>"+p_as_on_date+"</v2:item>\n" +
"                     </v2:values>\n" +
"                  </v2:item>\n" +
"               </v2:listOfParamNameValues>\n" +
"            </v2:parameterNameValues>\n" +
"            <v2:reportAbsolutePath>/Custom/Custom PasS/Report/Project Summary.xdo</v2:reportAbsolutePath>\n" +
"         </v2:reportRequest>\n" +
"         <v2:userID>kenneth.dcosta@omniyat.com</v2:userID>\n" +
"         <v2:password>Rd4q3XTS</v2:password>\n" +
"      </v2:runReport>\n" +
"   </soapenv:Body>\n" +
"</soapenv:Envelope>";
       return projectSummary;
}
    
}
