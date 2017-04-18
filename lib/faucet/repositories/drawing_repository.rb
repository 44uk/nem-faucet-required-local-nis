class DrawingRepository < Hanami::Repository
  def most_recent(count: 10)
    drawings
      .order { created_at.desc }
      .limit(count)
  end

  def recent_by_ipaddr(ipaddr, count: 10)
    drawings
      .where(ip: ipaddr)
      .where { created_at > (Time.now - 3_600) }
      .order { created_at.desc }
      .limit(count)
  end
end
