package util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class OJUtil {
	// private static final String
	// baseUrl="http://acm.imudges.com:666/JudgeOnline/";
	// private static final String
	// problemUrl="http://acm.imudges.com:666/JudgeOnline/problem.php?id=";
	private static final String userInfoUrl = "http://acm.imudges.com:666/JudgeOnline/userinfo.php?user=";

	public static List<String> getList(String username) throws IOException {
		Document document = Jsoup.connect(userInfoUrl + username).execute().parse();
		Elements td = document.select("td[rowspan=14]");
		String tdString = td.html();
		Pattern pattern = Pattern.compile("[0-9]{4}");
		Matcher matcher = pattern.matcher(tdString);
		List<String> data = new ArrayList<>();
		while (matcher.find()) {
			data.add(matcher.group(0));
		}
		return data;
	}

	public static boolean exist(String username) throws IOException {
		String html = Jsoup.connect(userInfoUrl + username).execute().parse().html();
		if (html.contains("No such User!")) {
			return false;
		}
		return true;
	}
}
