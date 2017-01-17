package org.seckill.util;

public class Test {
	public static void main(String[] args) {
		
		char c = 'a';
		int b = (int)c;
		System.out.println(b);
		
		char[] ch = new char[1024];
		System.out.println((int)ch['a']+"--333");
		System.out.println((int)ch[0]+"--222");
		for(int i = 0; i < 3; i++){
			//int a = ++ch[(int)'+'];
			int a = ch['a']++;
			System.out.println(a);
			System.out.println((int)ch['e']+"---");
		}
	}
}
