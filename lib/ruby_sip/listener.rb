$trying = "SIP/2.0 100 Trying
Via: SIP/2.0/UDP 192.168.6.40:5062;rport=5062;branch=z9hG4bKrrxiacvp
From: %s
To: %s
Call-ID: %s
CSeq: %s
User-Agent: RubySip
Content-Length: 0
"
"INVITE sip:blah@192.168.6.40:5061 SIP/2.0\r\nVia: SIP/2.0/UDP 192.168.6.40;rport;branch=z9hG4bKKv1g4cFHc199j\r\nMax-Forwards: 69\r\nFrom: \"Extension 1000\" <sip:1000@192.168.6.40>;tag=r8g7m62Kjt4ja\r\nTo: <sip:blah@192.168.6.40:5061>\r\nCall-ID: 3695b7f3-9e03-122e-b3a9-60eb69502500\r\nCSeq: 7361818 INVITE\r\nContact: <sip:mod_sofia@192.168.6.40:5060>\r\nUser-Agent: FreeSWITCH-mod_sofia/1.0.head-git-cc06fdb 2011-01-17 10-41-01 -0600\r\nAllow: INVITE, ACK, BYE, CANCEL, OPTIONS, MESSAGE, UPDATE, INFO, REGISTER, REFER, NOTIFY, PUBLISH, SUBSCRIBE\r\nSupported: timer, precondition, path, replaces\r\nAllow-Events: talk, hold, presence, dialog, line-seize, call-info, sla, include-session-description, presence.winfo, message-summary, refer\r\nContent-Type: application/sdp\r\nContent-Disposition: session\r\nContent-Length: 313\r\nX-FS-Support: update_display\r\nRemote-Party-ID: \"Extension 1000\" <sip:1000@192.168.6.40>;party=calling;screen=yes;privacy=off\r\n\r\nv=0\r\no=FreeSWITCH 1295374608 1295374609 IN IP4 192.168.6.40\r\ns=FreeSWITCH\r\nc=IN IP4 192.168.6.40\r\nt=0 0\r\nm=audio 21156 RTP/AVP 8 98 99 9 0 3 101 13\r\na=rtpmap:98 G7221/32000\r\na=fmtp:98 bitrate=48000\r\na=rtpmap:99 G7221/16000\r\na=fmtp:99 bitrate=32000\r\na=rtpmap:101 telephone-event/8000\r\na=fmtp:101 0-16\r\na=ptime:20\r\n"
module RubySip
  module Listener
    def post_init
      puts "Got Connection"
    end

    def receive_data data
      prelude, content = data.split("\r\n", 2)
      raw_headers, body = content.split("\r\n\r\n", 2)
      p prelude: prelude
      p raw_headers: raw_headers
      headers = headers_2_hash(raw_headers)
      p headers: headers
      p body: body
      case prelude
      when /INVITE/
        send_data $trying % [headers["To"],
                             headers["From"],
                             gen_id,
                             headers["CSeq"]]
      else
        p "No idea what to do!"
      end
    end

    def gen_id
      "3695b7f3-9e03-122e-b3a9-60eb69502500"
    end

    def headers_2_hash(hdrs)
      hash = {}
      hdrs.each_line{|h|
        k, v = h.split(": ", 2)
        hash[k] = v.chomp
      }
      hash
    end
  end
end

