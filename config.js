// 멍냥이 동산 서비스 설정
// Supabase 대시보드 > Project Settings > API 에서 아래 두 값을 복사해 넣으세요.
// anon(공개) 키는 브라우저에 공개돼도 괜찮은 키예요. 데이터는 supabase.sql의 RLS 규칙으로 보호돼요.
// 두 값을 비워 두면: 저장은 이 브라우저에만, 마을 동산은 "같은 브라우저 탭끼리" 테스트 모드로 동작해요.
window.DONGSAN_CONFIG = {
  supabaseUrl: 'https://oxuebfinflzhofafysry.supabase.co',      // 예: 'https://abcdefgh.supabase.co'
  supabaseAnonKey: 'sb_publishable_kEPLViHvJNGIpAsyFHsM3w_36XEOEb5',  // 예: 'eyJhbGciOi...'
  maxPerRoom: 8         // 마을 동산 한 방 최대 인원
};
