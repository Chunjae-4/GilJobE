package com.giljobe.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import org.json.JSONArray;
import org.json.JSONObject;

public class NaverGeoUtils {

    private static final String CLIENT_ID;
    private static final String CLIENT_SECRET;

    static {
        String id = "";
        String secret = "";
        try {
            // ✅ properties 경로가 실제로 잘 불러와지는지 확인
            URL propUrl = NaverGeoUtils.class.getClassLoader().getResource("api/naver.properties");

            InputStream input = propUrl.openStream(); // 이렇게 바꾸면 명확하게 확인 가능
            Properties props = new Properties();
            props.load(input);
            id = props.getProperty("naver.map.key");
            secret = props.getProperty("naver.map.secret.key");
        } catch (Exception e) {
            e.printStackTrace();
        }
        CLIENT_ID = id;
        CLIENT_SECRET = secret;
    }


    public static double[] getCoordinatesFromAddress(String address) {
        try {
            String query = URLEncoder.encode(address, "UTF-8");
            //String apiURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + query;
            String apiURL = "https://maps.apigw.ntruss.com/map-geocode/v2/geocode?query=" + query;


            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", CLIENT_ID);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", CLIENT_SECRET);

            // ✅ 여기서 응답 코드 확인
            int responseCode = con.getResponseCode();
            if (responseCode == 200) {
                // 성공한 경우
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();

                JSONObject json = new JSONObject(sb.toString());
                JSONArray addresses = json.getJSONArray("addresses");

                if (addresses.length() > 0) {
                    JSONObject obj = addresses.getJSONObject(0);
                    double latitude = obj.getDouble("y");
                    double longitude = obj.getDouble("x");
                    return new double[] { latitude, longitude };
                }

            } else {
                // ❗ 실패한 경우 (401 등), 에러 메시지를 따로 읽어 출력
                LoggerUtil.debug("❌ 응답 코드: " + responseCode);
                BufferedReader errReader = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
                StringBuilder errMsg = new StringBuilder();
                String line;
                while ((line = errReader.readLine()) != null) {
                    errMsg.append(line);
                }
                errReader.close();
                LoggerUtil.debug("❌ 에러 메시지: " + errMsg.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new double[] { 0.0, 0.0 }; // 실패 시 기본값
    }

}
