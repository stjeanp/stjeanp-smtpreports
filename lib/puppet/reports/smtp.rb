require 'puppet'
require 'yaml'
require 'net/smtp'

Puppet::Reports.register_report(:smtp) do
  configfile = File.join([File.dirname(Puppet.settings[:config]),
                          'smtpreports.yaml'])
  raise(Puppet::ParseError, "SMTP report config file #{configfile} does not exist!") unless File.exist?(configfile)
  SMTP_CONFIG = YAML.load_file(configfile)

  desc <<-DESC
  Send report information to recipients via SMTP.
  DESC

  def process
    if status == 'failed'
      Puppet.debug "Sending status for #{host} via SMTP"

      if SMTP_CONFIG[:smtp_auth_type]
        SMTP_CONFIG[:smtp_auth_type] = SMTP_CONFIG[:smtp_auth_type].to_sym
      end

      smtp_con = Net::SMTP.new(SMTP_CONFIG[:smtp_server],
                               SMTP_CONFIG[:smtp_port])
      smtp_con.start('localhost',
                     SMTP_CONFIG[:smtp_account],
                     SMTP_CONFIG[:smtp_secret],
                     SMTP_CONFIG[:smtp_auth_type])

      msg_str = "From: #{SMTP_CONFIG[:smtp_from]}\n"
      msg_str += "To: #{SMTP_CONFIG[:smtp_to]}\n"
      msg_str += "Subject: #{host} run failed!\n\n"
      msg_str += "The catalog run for #{host}, started at #{time}, failed!\n"

      smtp_con.send_message(msg_str,
                            SMTP_CONFIG[:smtp_from],
                            SMTP_CONFIG[:smtp_to])
      smtp_con.finish
    end
  end
end
