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

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.sql.SQLException;
 
import java.util.concurrent.TimeUnit;
import javax.naming.NamingException;
 
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
 
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
 
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
 
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
 
import javax.xml.bind.DatatypeConverter;

/**
 *
 * @author gautham.r
 */
public class InvokeReport {
    WsPayload payload = new WsPayload();
    DbPackageCall invokePkg = new DbPackageCall();
   
    public void projectSummary(long p_bu_id,String p_status,String p_as_on_date) throws SQLException, NamingException, ClassNotFoundException  {
        String xmlInput = payload.getProjectSummary(p_bu_id,p_status,p_as_on_date);
        String xmlData = invokeReport(xmlInput);
        System.out.println("REport Output:"+xmlData);
        invokePkg.projectSummarySync(p_bu_id,p_as_on_date,xmlData);
    }
   
    public synchronized String invokeReport(String xmlInput)  {
        OkHttpClient client = new OkHttpClient();
        OkHttpClient.Builder builder1 = new OkHttpClient.Builder();
        builder1.connectTimeout(30, TimeUnit.SECONDS);
        builder1.readTimeout(30, TimeUnit.SECONDS);
        builder1.writeTimeout(30, TimeUnit.SECONDS);
        client = builder1.build();
        MediaType mediaType = MediaType.parse("text/xml");
        String reportResponse = null;
        RequestBody body = RequestBody.create(mediaType, xmlInput);
//        System.out.println("Request Payload ----> " + xmlInput);
        String error = null;
        
        Request request
                = new Request.Builder().url("https://ejds.fa.em2.oraclecloud.com/xmlpserver/services/v2/ReportService").post(body).addHeader("content-type",
                "text/xml").addHeader("cache-control",
                        "no-cache").addHeader("SOAPAction",
                        "").build();
        try {
 
            Response response = client.newCall(request).execute();
            InputStream isr = response.body().byteStream();
            BufferedReader reader
                    = new BufferedReader(new InputStreamReader(isr));
            StringBuilder out = new StringBuilder();
            String resultsXml;
            while ((resultsXml = reader.readLine()) != null) {
                out.append(resultsXml);
            }
 
            int responseCode = response.code();
            if (responseCode > 200) {
                String fault = null;
 
                if (out.toString().contains(";TEXT&gt;")) {
                    fault = getFaultString(out.toString());
                } else {
                    DocumentBuilder builder
                            = DocumentBuilderFactory.newInstance().newDocumentBuilder();
                    InputSource src = new InputSource();
                    src.setCharacterStream(new StringReader(out.toString()));
                    Document doc = builder.parse(src);
                    System.err.println("Error Response----> "
                            + out.toString());
                    fault
                            = doc.getElementsByTagName("faultstring").item(0).getTextContent();
                }
 
            } else {
                reportResponse = getResponseAsString(out.toString());
//                System.out.println("Report Reponse : " + reportResponse);
                DocumentBuilder db;
                db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
                InputSource is = new InputSource();
                is.setCharacterStream(new StringReader(reportResponse));
                Document doc = db.parse(is);
                NodeList nodes = doc.getElementsByTagName("G_1");
            }
            reader.close();
        } catch (Exception e) {
            error = e.toString();
            
            
            e.printStackTrace();
        }
        return reportResponse;
    }
 
    public synchronized static String getResponseAsString(String resp) throws ParserConfigurationException,
            SAXException,
            IOException {
        String response = resp;
        DocumentBuilder builder
                = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        InputSource src = new InputSource();
        src.setCharacterStream(new StringReader(response));
        Document doc = builder.parse(src);
        response
                = doc.getElementsByTagName("reportBytes").item(0).getTextContent();
 
        /**
         * *****DECODE BYTES TO STRING***********
         */
        byte[] val = DatatypeConverter.parseBase64Binary(response);
        response = new String(val);
        return response;
    }
 
    public synchronized static String getFaultString(String xml) {
 
        String faultString = "";
        int firstFault = xml.indexOf(";TEXT&gt;");
        int firstFault_last = xml.indexOf("&lt;/TEXT&");
        faultString = xml.substring(firstFault + 9, firstFault_last);
        System.err.println("FAULT STRING : " + faultString);
        return faultString;
    }
    }

