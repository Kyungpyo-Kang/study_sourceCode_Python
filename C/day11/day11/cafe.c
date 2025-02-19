#include<stdio.h>
#include<string.h>
#define CNT 100
void main() {
	//추가, 수정, 삭제, 검색, 목록
	//상품명 - 가격
	//twosome place

	char title[20] = "★Twosome place★";
	char menu[100] = "①추가하기\n②수정하기\n③삭제하기\n④검색하기\n⑤목록보기\n⑥나가기\n";
	char errMsg[30] = "다시 선택해주세요.\n";

	//상품명을 저장할 문자열 배열
	char arName[CNT][100] = { "", };

	//상품 가격을 저장할 정수 배열
	int arPrice[CNT] = { 0, };
	//사용자가 입력한 상품명을 임시로 저장할 공간
	char temp[100] = { "", };

	int choice = 0;

	//추가한 상품의 총 개수
	int insertCnt = 0;

	//for문 밖에서도 i를 사용해야 하므로 전역변수로 선언
	int i = 0;

	while (1) {
		printf("%s\n%s", title, menu);
		scanf_s("%d", &choice);

		//나가기
		if (choice == 6) { break; }
		switch (choice) {

		//추가하기
		case 1:
			printf("상품명 : ");
			scanf_s("%s", &choice);
			//만약 상품이 한개도 없다면 중복검사를 할 필요가 없다.
			if (insertCnt != 0) {
				//상품이 하나라도 있다면 들어온다.
				//추가된 상품개수만큼 반복
				for (i = 0; i < insertCnt; i++) {
					//사용자가 추가할 상품명과 일치하는 상품명이 존재하면 break
					if (!strcmp(arName[i], temp)) {
						break;
					}
				}
			}
			//위에서 break를 만났다는 것은 중복된 상품이 있다는 뜻!
			//따라서 i 가 insertCnt까지 증가하기 위해서는 중복이 없어야 한다.
			if (i == insertCnt) {
				//중복이 없으면 들어옴
				printf("가격 : ");
				scanf_s("%d", arPrice + insertCnt);
				strcpy_s(arName[insertCnt], sizeof(arName[insertCnt]), temp);
				//추가 완료시 총 상품개수 1 증가
				insertCnt++;
			}
			else {
				printf("중복된 상품명");
			}





			break;
		//수정하기
		case 2:
			break;
		//삭제하기
		case 3:
			printf("삭제할 상품명 : ");
			scanf_s("%s", temp);

			//총 상품 개수만큼 반복
			for (i = 0; i < insertCnt; i++) {
				//삭제할 상품이 있는지 검사
				if (!strcmp(temp, arName[i])) {
					//삭제할 상품이 있다면 그 상품행에 다음 행을 덮어씌운다.
					//insertCnt번째 방까지 반복한다.
					for (int j = i; j < insertCnt; j++) {
						//상품명 삭제
						strcpy_s(arName[i], sizeof(arName[i]), arName[i + 1]);
						//가격 삭제
						arPrice[i] = arPrice[i + 1];
					}
					//삭제 완료 후 총 상품개수 1 감소
					insertCnt--;
					break;
				}
			}
			//위에서 삭제할 상품이 없다면 오류 메시지 출력
			if (i == insertCnt) {
				printf("삭제하실 상품이 존재하지 않습니다.\n");
			}
			break;
		//검색하기
		case 4:
			break;
		//목록보기
		case 5:
			//만약 총 상품개수가 0개라면 목록없음이 출력되고 1개라도 있다면 <상품명(가격)>이 출력된다.
			strcpy_s(temp, sizeof(temp), insertCnt==0? "목록 없음" : "<상품명(가격)>\n");
			printf("%s\n", temp);
			for ( i = 0; i < insertCnt; i++) {
				//총 상품 개수만큼 순서대로 출력
				printf("%s(%d원)\n", arName[i], arPrice[i]);
			}
			break;
		//오류
		default:
			printf(errMsg);
		}
	}




}