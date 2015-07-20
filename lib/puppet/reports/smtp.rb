require 'puppet'
require 'yaml'
require 'net/smtp'

unless Puppet.version >= '3.0.0'
  fail "This report processor requires Puppet version 3.0.0 or later"
end

Puppet::Reports.register_report(:smtp) do
  configfile = File.join([File.dirname(Puppet.settings[:config]), 'smtpreports.yaml'])
  unless File.exist?(configfile)
    raise(Puppet::ParseError, "SMTP report config file #{configfile} missing or not readable!")
  end
  CONFIG = YAML.load_file(configfile)

  desc <<-DESC
  Send report information to recipients via SMTP.
  DESC

  def process
    case status
    when 'failed'
      info = 'failed!'
    when 'changed'
      info = 'had changes.'
    else
      return true
    end

    if CONFIG[:smtp_auth_type]
      CONFIG[:smtp_auth_type] = CONFIG[:smtp_auth_type].to_sym
    end

    msg_str = "From: #{CONFIG[:smtp_from]}\n"
    msg_str += "To: #{CONFIG[:smtp_to]}\n"
    msg_str += "Subject: Puppet catalog run on #{host} #{info}\n\n"
    msg_str += "The catalog run on #{host}, started at #{time}, #{info}\n"

    begin
      smtp_con = Net::SMTP.new(CONFIG[:smtp_server],
                               CONFIG[:smtp_port])
      smtp_con.start(CONFIG[:smtp_helo],
                     CONFIG[:smtp_account],
                     CONFIG[:smtp_secret],
                     CONFIG[:smtp_auth_type])

      smtp_con.send_message(msg_str,
                            CONFIG[:smtp_from],
                            CONFIG[:smtp_to].split(","))
      smtp_con.finish
    rescue Exception => e
      Puppet.err("Failed to send SMTP report: #{e.message}")
    end
  end
end
